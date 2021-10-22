class OrdersController < ApiController

  def index
    orders = Order.ransack(index_params).result
    render json: {
      orders: each_serialize(orders),
      total_count: orders.count
    }
  end

  def show
    order = Order.find(params[:id])
    render json: serialize(order)
  end

  def create
    order = Order.create(object_params)
    render json: serialize(order)
  end

  def update
    order = User.find(params[:user_id]).orders.cart.first_or_create
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
