FactoryBot.define do
  factory :delivery_order do
    order_id Faker::Code.asin
    serving_datetime  Faker::Time.between(2.days.ago, Date.today, :all)
  end
end