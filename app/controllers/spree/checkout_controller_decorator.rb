
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
        redirect_to calculator.preferred_kiala_service_url #todo add params.
      end

    end
  end
end