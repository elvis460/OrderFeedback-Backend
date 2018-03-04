class OrdersController < ApplicationController
  def index
    @orders = DeliveryOrder.includes(:order_items).order(created_at: :desc)
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

  def create_feedbacks
    params[:feedbacks].each do |feedback|
      new_feedback = Feedback.new(feedback_params(feedback))
      unless new_feedback.valid? && new_feedback.save
        render json: {'status': 'Failed', 'msg': 'Required attribute empty'}, status: :bad_request
        return
      end
    end
    
    render json: {'status': 'OK'}, status: :ok
  end


  private

  def render_json(method)
    respond_to do |format|
      format.html {render template: "orders/#{method}.json.jbuilder"}
    end
  end

  def feedback_params(feedback)
    feedback.permit(:ratable_id, :ratable_type, :rating, :comment)
  end

end
