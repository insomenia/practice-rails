class LineItemEachSerializer < Panko::Serializer
  attributes :id, :item_id, :order_id, :quantity, :total
end
