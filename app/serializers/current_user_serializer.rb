class CurrentUserSerializer < Panko::Serializer
  # include ImagableSerializer
  # has_one :image, serializer: V1::ImageSerializer
  
  attributes :id, :email, :name, :gender, :zipcode, :address1, :address2
end
