module Spree
  module Admin
    Spree::Admin::OrdersController.class_eval do

      respond_to :html

      def shipment_state_upgrade
        state = params[:state] || "shipped"
        order = Spree::Order.find_by_number(params[:id])
        order.update(:shipment_state => state)

        order.shipments.each do |shipment|
          shipment.update(:state => state)
        end

        redirect_to edit_admin_order_url
      end

    end
  end
end
