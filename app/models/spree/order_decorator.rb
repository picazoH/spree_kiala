module Spree
  Order.class_eval do
    has_one :kiala_points, :dependent => :destroy, :class_name => "Spree::KialaPoint"
  end
end
