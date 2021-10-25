class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  PERMIT_COLUMNS = [:item_id, :quantity].freeze
end
