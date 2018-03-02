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
    get '/orders'
    # check status
    expect(response).to have_http_status 200
    # check count
    json = JSON.parse(response.body)
    expect(json['orders'].length).to eq 1  

    # check content
    expected = {
      orders: [
        {
          order_id: @delivery_order.order_id,
          delivery_date: @delivery_order.serving_datetime.strftime('%F'),
          delivery_time: show_delivery_time(@delivery_order.serving_datetime)
        }
      ]
    }
    expect(response.body).to eq expected.to_json
  end

  it '#show' do
    get "/orders/#{@delivery_order.order_id}"

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
end