class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  enum status: %i[cart ready paid complete]

  PERMIT_COLUMNS = [:receiver_name, :receiver_phone, :user_id, :status, :zipcode, :address1, :address2].freeze

  def add_new_line_item(params)
    line_items = self.line_items
    line_item = line_items.find_by(item_id: params[:item_id])
    if line_item.present?
      new_quantity = line_item.quantity + params[:quantity].to_i
      line_item.update(
        quantity: new_quantity,
        total: new_quantity * line_item.item.sale_price
      )
    else
      item = Item.find(params[:item_id])
      line_item = line_items.create(
        item_id: item.id,
        quantity: params[:quantity].to_i,
        total: params[:quantity].to_i * item.sale_price
      )
    end
    # update(total: calc_total)
    return line_item
  end
end
