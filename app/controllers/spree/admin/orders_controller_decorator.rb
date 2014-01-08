module Spree
  module Admin
    Spree::Admin::OrdersController.class_eval do

      respond_to :html

      def shipment_state_upgrade
        state = params[:state] || "shipped"
        order = Spree::Order.find_by_number(params[:id])
        order.update_attributes({:shipment_state => state}, :without_protection => true)

        order.shipments.each do |shipment|
          shipment.update_attributes({:state => state}, :without_protection => true)
        end

        redirect_to edit_admin_order_url
      end

    end
  end
end
