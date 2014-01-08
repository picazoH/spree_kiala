require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
  class FlatInRange < ShippingCalculator
    preference :private_area_url,  :string
    preference :lower_boundry,     :decimal, :default => 0.0
    preference :upper_boundry,     :decimal, :default => 50.0
    preference :amount,            :decimal, :default => 5.0

    attr_accessible :preferred_private_area_url,
                    :preferred_lower_boundry, :preferred_upper_boundry, :preferred_amount

    def self.description
      I18n.t(:FlatInRange)
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