class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  before_save :set_total
  PERMIT_COLUMNS = [:item_id, :quantity].freeze

  def set_total
    self.total = item.sale_price * quantity
  end
end
