require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OrdersHelper. For example:
#
# describe OrdersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe OrdersHelper, type: :helper do
  it '#cal_total_price' do
    meal = create(:meal)
    item = create(:order_item, quantity:100, unit_price: 66, delivery_order_id: 1, meal_id: meal.id)
    expect(cal_total_price(item)).to eq (6600)
  end
end
