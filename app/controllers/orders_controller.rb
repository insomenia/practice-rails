class OrdersController < ApiController
  before_action :authorize_access_request!
  def index
    orders = current_api_user.orders.ransack(index_params).result
    render json: {
      orders: each_serialize(orders),
      total_count: orders.count
    }
  end

  def cart
    order = current_api_user.cart
    render json: serialize(order, serializer_name: CartSerializer)
  end

  def show
    order = current_api_user.orders.find(params[:id])
    render json: serialize(order)
  end

  def create
    order = current_api_user.orders.create(object_params)
    render json: serialize(order)
  end

  def update
    order = current_api_user.cart
    order.update(object_params)
    order.complete!
    render json: serialize(order)
  end

  private

  def index_params
    params.fetch(:q, {}).permit(:s, :category_id_eq)
  end

  def object_params
    params.fetch(:order).permit(Order::PERMIT_COLUMNS)
  end
end
