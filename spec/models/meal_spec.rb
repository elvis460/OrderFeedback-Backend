require 'rails_helper'

RSpec.describe Meal, type: :model do
  it 'is accessible' do
    meal = create(:meal)
    expect(meal).to eq(Meal.last)
  end

  it 'has correct column' do
    columns = Meal.column_names
    expect(columns).to include ("name")
    expect(columns).to include ("byline")
  end

  it "has_many order_items" do
    meal = create(:meal)
    order_items = meal.order_items.create(delivery_order_id: 1, serving_date: Time.now.to_datetime, quantity: 1, unit_price: 10)
    expect(meal.order_items).to include order_items
  end
end
