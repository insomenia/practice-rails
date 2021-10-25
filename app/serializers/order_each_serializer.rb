class OrderEachSerializer < Panko::Serializer
  attributes :id, :status, :receiver_name, :receiver_phone
end
