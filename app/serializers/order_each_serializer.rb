class OrderEachSerializer < Panko::Serializer
  attributes :id, :status, :receiver_name, :receiver_phone

  def status
    object.enum_ko(:status)
  end
end
