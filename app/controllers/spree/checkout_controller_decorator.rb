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


    def redirect_url_kiala(calculator, order)
      url = calculator.preferred_kiala_service_url
      dspid  = calculator.preferred_dspid
      preparation_delay = calculator.preferred_preparationdelay
      language = I18n.locale.to_s

      address = order.ship_address
      zipcode = address.zipcode
      street = address.address1
      city = address.city
      country = address.country.iso

      url += "?dspid=#{dspid}&country=#{country}&language=#{language}&preparationdelay=#{preparation_delay}"
      url += "&street=#{street}&zip=#{zipcode}&city=#{city}"
      URI.escape(url)

      #KAO http://locateandselect.kiala.com/locateandselect/search?dspid=demo_dsp&country=ES&language=es&preparationdelay=1&street=caballero%2091&zip=08029&city=barcelona
      #OK http://locateandselect.kiala.com/locateandselect/search?dspid=demo_dsp&preparationdelay=&language=es&country=ES&street=caballero+91&zip=08029&city=Barcelona
      #http://locateandselect.kiala.com/locateandselect/search?pl=map&country=ES&target=_parent&bckUrl=testbckurl.html%3Forder%3D12345%26&dspid=demo_dsp&zip=08012&language=es&city=Barcelona
    end


  end
end