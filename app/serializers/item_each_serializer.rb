class ItemEachSerializer < Panko::Serializer
  include ImagableSerializer

  attributes :id, :user_id, :name, :list_price, :sale_price, :category_id

  has_one :category, serializer: CategorySerializer
end
