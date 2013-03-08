require 'uri'

module Spree
  CheckoutController.class_eval do
    before_filter :redirect_to_kiala_locate_and_select_service_if_needed, :only => [:update]

    def redirect_to_kiala_locate_and_select_service_if_needed
      return unless (params[:state] == "delivery")
      return unless params[:order][:shipping_method_id]

      if @order.update_attributes(object_params)
        fire_event('spree.checkout.update')
        render :edit and return unless apply_coupon_code
      end

      load_order
      if not @order.errors.empty?
        render :edit and return
      end

      if @order.shipping_method.calculator.kind_of?(Spree::Calculator::Kiala)
        calculator = @order.shipping_method.calculator
        redirect_to redirect_url_kiala(calculator, @order)
      else
        kpoint = find_kp_by_order(@order)
        unless kpoint.nil?
          kpoint.destroy
        end
      end

    end

    def find_kp_by_order(order)
      Spree::KialaPoint.find_by_order_id(order)
    end

    def kiala_opts(calculator, address)
      opts = { :dspid             => calculator.preferred_dspid,
               :country           => address.country.iso,
               :language          => I18n.locale.to_s,
               :preparation_delay => calculator.preferred_preparationdelay,
               :zipcode           => address.zipcode,
               :street            => address.address1,
               :city              => address.city,
               :callback_url      => kiala_confirm_checkout_url  #callback_url see the routes
      }
    end

    def redirect_url_kiala(calculator, order)
      url = calculator.preferred_kiala_service_url
      opts = kiala_opts(calculator, order.ship_address)
      #common params
      url += "?dspid=#{opts[:dspid]}&country=#{opts[:country]}&language=#{opts[:language]}&preparationdelay=#{opts[:preparation_delay]}"
      #address
      url += "&street=#{opts[:street]}&zip=#{opts[:zipcode]}&city=#{opts[:city]}"
      #callback, important to add '?' to receive the params from kiala
      url += "&bckUrl=#{opts[:callback_url]}?"
      URI.escape(url)
    end

    def kiala_confirm
      load_order
      kpoint = find_kp_by_order(@order)
      if kpoint.nil?
        Spree::KialaPoint.create(:shortkpid => params[:shortkpid],
                                 :order_id => @order.id,
                                 :kpname => params[:kpname],
                                 :street => params[:street],
                                 :zip => params[:zip],
                                 :city => params[:city],
                                 :locationhint => params[:locationhint],
                                 :openinghours => params[:openinghours],
                                 :label => params[:label])
      else
        kpoint.update_attributes(:shortkpid => params[:shortkpid],
                                 :kpname => params[:kpname],
                                 :street => params[:street],
                                 :zip => params[:zip],
                                 :city => params[:city],
                                 :locationhint => params[:locationhint],
                                 :openinghours => params[:openinghours],
                                 :label => params[:label])
      end
      redirect_to checkout_state_path(@order.checkout_steps.third)
    end


  end
end