require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    class Kiala < ShippingCalculator
      preference :dspid,             :string,  :default => 'demo_dsp'
      preference :kiala_service_url, :string,  :default => 'https://locateandselect.kiala.com/search'
      preference :private_area_url,  :string
      preference :preparationdelay,  :integer, :default => 1
      preference :lower_boundry,     :decimal, :default => 0.0
      preference :upper_boundry,     :decimal, :default => 50.0
      preference :amount,            :decimal, :default => 5.0

      def self.description
        I18n.t(:kiala_shipping)
      end

      def compute_package(package)
        item_total = package.order.total
        if (item_total >= self.preferred_lower_boundry && item_total <= self.preferred_upper_boundry)
          return self.preferred_amount
        else
          return 0.0
        end
      end
    end
  end
end