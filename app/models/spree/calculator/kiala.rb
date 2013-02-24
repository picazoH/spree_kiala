module Spree
  class Calculator::Kiala < Calculator::FlatInRange
    preference :dspid,    :String, :default => "demo"
    preference :country,  :String,:default  => "ES"
    preference :language,  :String,:default  => "es"
    preference :preparationdelay,  :int,:default  => 1
    preference :kiala_service_url, :string, :default => 'http://locateandselect.kiala.com/search'

    attr_accessible :dspid, :country, :language, :preparationdelay, :kiala_service_url
    def self.description
      I18n.t(:kiala_shipping)
    end

    def compute(object)
      super
    end
  end
end