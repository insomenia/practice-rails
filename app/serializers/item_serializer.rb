  class ItemSerializer < Panko::Serializer
    include ImagableSerializer
    attributes :id, :user_id, :name, :list_price, :sale_price, :description, :category_id
    has_many :images, serializer: ImageSerializer
  end
