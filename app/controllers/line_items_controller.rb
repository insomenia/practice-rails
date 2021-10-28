class LineItemsController < ApiController
  before_action :authorize_access_request!
  def create
    order = current_api_user.cart
    line_item = order.add_new_line_item(object_params)
    render json: serialize(line_item)
  end

  def destroy
    order = current_api_user.cart
    line_item = order.line_items.find(params[:id])
    line_item.destroy
  end

  def update
    order = current_api_user.cart
    line_item = order.line_items.find(params[:id])
    line_item.update(object_params.except(:item_id))
    render json: serialize(line_item)
  end

  private

  def object_params
    params.fetch(:line_item).permit(LineItem::PERMIT_COLUMNS)
  end
end
