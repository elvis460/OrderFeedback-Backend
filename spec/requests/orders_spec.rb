require 'rails_helper'
include OrdersHelper
require 'database_cleaner'

RSpec.describe 'orders',  type: :request do
  before(:all) do
    # clear db
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    # build fake data
    @meal = create(:meal)
    @delivery_order = create(:delivery_order)
    @order_item = create(:order_item, delivery_order_id: @delivery_order.id, meal_id: @meal.id)
  end  

  it '#index' do
    get '/orders', headers: { 'Auth-Token' => 'Auth-Token' }
    # check status
    expect(response).to have_http_status 200
    # check count
    json = JSON.parse(response.body)
    expect(json['orders'].length).to eq 1

    # check content
    expected = {
      orders: [
        {
          id: @delivery_order.id,
          order_id: @delivery_order.order_id,
          delivery_date: @delivery_order.serving_datetime.strftime('%F'),
          delivery_time: show_delivery_time(@delivery_order.serving_datetime),
          feedback_submitted: false,
          order_items: [
            {
              order_item_id: @order_item.id,
              name: @meal.name
            }
          ]
        }
      ]
    }
    expect(response.body).to eq expected.to_json
  end

  it '#show' do
    get "/orders/#{@delivery_order.order_id}", headers: { 'Auth-Token' => 'Auth-Token' }

    expect(response).to have_http_status 200
    
    expected = {
      order: {
        order_id: @delivery_order.order_id,
        delivery_date: @delivery_order.serving_datetime.strftime('%F'),
        delivery_time: show_delivery_time(@delivery_order.serving_datetime),
        order_items: [
          {
            name: @meal.name,
            quantity: @order_item.quantity,
            total_price: @order_item.quantity*@order_item.unit_price
          }
        ]
      }
    }
    expect(response.body).to eq expected.to_json
  end

  it '#create_feedbacks' do
    expect(Feedback.count).to eq(0)

    post "/orders/#{@delivery_order.order_id}/feedbacks", headers: { 'Auth-Token' => 'Auth-Token' },
     params: { feedbacks: [
        {
          ratable_id: @delivery_order.id,
          ratable_type: "DeliveryOrder",
          rating: 1,
          comment: 'Good'
        },
        {
          ratable_id: @order_item.id,
          ratable_type: "OrderItem",
          rating: -1,
          comment: 'Bad'
        }
      ]
    }

    expect(response).to have_http_status 200
    expect(Feedback.count).to eq(2)
    expect(@delivery_order.feedback.rating).to eq(1)
    expect(@order_item.feedback.comment).to eq('Bad')
  end

  it '#show_feedbacks' do
    @delivery_order.create_feedback(rating: 1, comment: 'Good')
    @order_item.create_feedback(rating: -1, comment: 'Bad')

    get "/orders/#{@delivery_order.order_id}/feedbacks", headers: { 'Auth-Token' => 'Auth-Token' }

    expected = {
      feedbacks: [
        {
          ratable_id: @order_item.id,
          ratable_type: "OrderItem",
          rating: -1,
          comment: 'Bad'
        },
        {
          ratable_id: @delivery_order.id,
          ratable_type: "DeliveryOrder",
          rating: 1,
          comment: 'Good'
        }
      ]
    }
    expect(response).to have_http_status 200
    expect(response.body).to eq expected.to_json
  end
end