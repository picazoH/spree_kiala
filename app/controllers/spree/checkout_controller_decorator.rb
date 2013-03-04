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
      end

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


    # Handle the incoming user from Kiala Locale&Select Service
    def kiala_confirm
      load_order
      #order_upgrade()
      #payment_upgrade()
      #flash[:notice] = I18n.t(:order_processed_successfully)
      #redirect_to completion_route
      redirect_to checkout_state_path(@order.checkout_steps.third)
    end


  end
end