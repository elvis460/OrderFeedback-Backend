require 'rails_helper'

RSpec.describe Feedback, type: :model do
   before(:all) do
    @meal = create(:meal)
    @delivery_order = create(:delivery_order)
    @order_items = @delivery_order.order_items.create(meal_id: @meal.id, serving_date: Time.now.to_datetime, quantity: 1, unit_price: 10)
  end 
  
  it 'is accessible' do
    feedback = Feedback.create(ratable_id: @delivery_order.id, ratable_type: "DeliveryOrder", rating: 1, comment: 'Test')
    expect(feedback).to eq(Feedback.last)
  end

  it 'has correct column' do
    columns = Feedback.column_names
    expect(columns).to include ("ratable_id")
    expect(columns).to include ("ratable_type")
    expect(columns).to include ("rating")
    expect(columns).to include ("comment")
  end

  it "valid columns" do
    expect(Feedback.create(ratable_id: @delivery_order.id)).not_to be_valid
    expect(Feedback.create(ratable_id: @delivery_order.id, ratable_type: "DeliveryOrder")).not_to be_valid
    expect(Feedback.create(ratable_id: @delivery_order.id, ratable_type: "DeliveryOrder", rating: 1)).to be_valid
  end
end
