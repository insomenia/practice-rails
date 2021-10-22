class LineItemSerializer < Panko::Serializer
  attributes :id, :item, :order, :quantity, :total

  def item
    object.item
  end

  def order
    object.order
  end

end
