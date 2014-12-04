module Spree
  module Admin
    Spree::Admin::OrdersController.class_eval do

      respond_to :html

      def shipment_state_upgrade
        state = params[:state] || "shipped"
        @order.update(:shipment_state => state)
        @order.shipments.each do |shipment|
          shipment.update(:state => state)
        end
        redirect_to edit_admin_order_url
      end

      def undo_approve_order
        @order.update(:approver_id => nil, :approved_at => nil)
        redirect_to edit_admin_order_url
      end

    end
  end
end
