FactoryBot.define do
  factory :order_item do
    serving_date  Faker::Time.between(2.days.ago, Date.today, :all)
    quantity Faker::Number.digit
    unit_price Faker::Number.digit
  end
end