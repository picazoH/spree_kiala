module Spree
  module Admin
    Spree::Admin::ShipmentsController.class_eval do

      respond_to :html

      def shipment_state_upgrade
        state = params[:state] || "shipped"
        shipment = Spree::Shipment.find_by_number(params[:id])
        shipment.update_attributes({:state => state}, :without_protection => true)
        order = Spree::Order.find_by_number(params[:order_id])
        order.update_attributes({:shipment_state => state}, :without_protection => true)
        redirect_to edit_admin_order_shipment_url
      end

    end
  end
end
