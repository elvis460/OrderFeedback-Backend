require 'rails_helper'

RSpec.describe DeliveryOrder, type: :model do
  it 'is accessible' do
     # clear db
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    
    order = create(:delivery_order)
    expect(order).to eq(DeliveryOrder.last)
  end

  it 'has correct column' do
    columns = DeliveryOrder.column_names
    expect(columns).to include ("order_id")
    expect(columns).to include ("serving_datetime")
  end

  it 'valid order_id' do
    order_id = "ORD111"
    expect(DeliveryOrder.new).not_to be_valid
    expect(DeliveryOrder.create(order_id: order_id)).to be_valid
    # same order_id is not validate
    expect(DeliveryOrder.create(order_id: order_id)).not_to be_valid
  end

  it "has_many order_items" do
    order = create(:delivery_order)
    order_items = order.order_items.create(delivery_order_id: 1, serving_date: Time.now.to_datetime, quantity: 1, unit_price: 10)
    expect(order.order_items).to include order_items
  end
end
