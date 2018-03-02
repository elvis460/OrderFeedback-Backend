class OrdersController < ApplicationController
  def index
    @orders = DeliveryOrder.all
    # force request to redner json (no html view now.)
    render_json('index')
  end

  def show
    @order = DeliveryOrder.find_by(order_id: params[:id])
    if @order
      @order_items = @order.order_items
      # force request to redner json (no html view now.)
      render_json('show')
    else
      render json: {'status': 'Failed', 'msg': 'Order_id Not Found'}, status: :not_found
    end
  end


  private

  def render_json(method)
    respond_to do |format|
      format.html {render template: "orders/#{method}.json.jbuilder"}
    end
  end
end
