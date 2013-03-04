class Spree::Kialapoint < ActiveRecord::Base
  attr_accessible :city, :kpname, :label, :locationhint, :openinghours, :shortkpid, :street, :zip
end
