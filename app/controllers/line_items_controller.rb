class LineItemsController < ApiController

  def create
    order = User.find(params[:user_id]).orders.cart.first_or_create
    line_item = order.add_new_line_item(object_params)
    render json: serialize(line_item)
  end

  private

  def object_params
    params.fetch(:line_item).permit(LineItem::PERMIT_COLUMNS)
  end

end
