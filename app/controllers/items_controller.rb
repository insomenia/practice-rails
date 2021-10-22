class ItemsController < ApiController
  def index
    items = Item.ransack(index_params).result.page(params[:page])
    render json: {
      items: each_serialize(items),
      total_count: items.count
    }
  end

  def show
    item = Item.find(params[:id])
    render json: serialize(item)
  end

  private

  def index_params
    params.fetch(:q, {}).permit(:s, :category_id_eq, :created_at_lteq, :created_at_gteq, :list_price_lteq, :list_price_gteq, :sale_price_lteq, :sale_price_gteq, :name_cont)
  end
end
