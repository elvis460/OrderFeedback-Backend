class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :show_feedbacks]

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

  def show_feedbacks
    if @order
      @feedbacks = @order.order_items.map{|item| item.feedback}
      @feedbacks << @order.feedback
      # force request to redner json (no html view now.)
      render_json('show_order_feedbacks')
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

  def feedback_params(feedback)
    feedback.permit(:ratable_id, :ratable_type, :rating, :comment)
  end

  def find_order
    @order = DeliveryOrder.find_by(order_id: params[:id])
  end

end
