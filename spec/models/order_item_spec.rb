require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:all) do
    @meal = create(:meal)
    @delivery_order = create(:delivery_order)
  end 
  
  it 'is accessible' do
    order_item = create(:order_item, delivery_order_id: @delivery_order.id, meal_id: @meal.id)
    expect(order_item).to eq(OrderItem.last)
  end

  it 'has correct column' do
    columns = OrderItem.column_names
    expect(columns).to include ("delivery_order_id")
    expect(columns).to include ("serving_date")
    expect(columns).to include ("meal_id")
    expect(columns).to include ("quantity")
    expect(columns).to include ("unit_price")
  end

  it "belongs_to meal" do
    order_item = create(:order_item, delivery_order_id: @delivery_order.id, meal_id: @meal.id)
    expect(order_item.meal).to eq(@meal)
  end
end
