class Spree::KialaPoint < ActiveRecord::Base
  belongs_to :order

  validates :shortkpid, :presence => true
end
