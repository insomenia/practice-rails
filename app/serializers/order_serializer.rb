class OrderSerializer < Panko::Serializer
  attributes :id, :status, :receiver_name, :receiver_phone, :zipcode, :address1, :address2

  def status
    object.enum_ko(:status)
  end
end
