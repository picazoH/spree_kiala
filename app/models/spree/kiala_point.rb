class Spree::KialaPoint < ActiveRecord::Base
  belongs_to :order

  attr_accessible :city, :kpname, :label, :locationhint, :openinghours, :order_id, :shortkpid, :street, :zip
  validates :shortkpid, :presence => true
end
