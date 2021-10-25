class CartSerializer < Panko::Serializer
  attributes :id, :status, :receiver_name, :receiver_phone, :zipcode, :address1, :address2
  has_many :line_items
end
