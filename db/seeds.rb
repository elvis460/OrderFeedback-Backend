# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

create_meals = [
  {name: 'Laksa Potato Salad'}, 
  {name: 'Beef Bulgogi Bibimbap'}, 
  {name: 'Tofu‑Powered Tabbouleh'},
  {name: 'Grilled Farm Fresh Chicken'},
  {name: 'Pan‑seared Norwegian Salmon'},
  {name: 'Roasted Thai Chicken with Sautéed Greens'},
  {name: 'Thunder Matcha Tea Rice'},
  {name: 'Mediterranean Chickpea Salad'},
  {name: 'Prawn Gyoza'},
  {name: 'Chocolate Banana Crumble Tart'}
]

meals = Meal.create(create_meals)


create_delivery_orders = [
  {order_id: "ORD#{Time.now.to_i}", serving_datetime: Time.now.to_datetime},
  {order_id: "ORD#{(Time.now + 10).to_i}", serving_datetime: (Time.now + 10).to_datetime},
  {order_id: "ORD#{(Time.now + 20).to_i}", serving_datetime: (Time.now + 20).to_datetime}
]

delivery_orders = DeliveryOrder.create(create_delivery_orders)


create_order_items = [
  {delivery_order_id: delivery_orders.first.id, serving_date: Time.now.to_datetime, meal_id: meals.first.id, quantity: 1, unit_price: 10},
  {delivery_order_id: delivery_orders[1].id, serving_date: (Time.now + 10).to_datetime, meal_id: meals[1].id, quantity: 3, unit_price: 15},
  {delivery_order_id: delivery_orders[2].id, serving_date: (Time.now + 20).to_datetime, meal_id: meals[2].id, quantity: 2, unit_price: 9}
]

order_items = OrderItem.create(create_order_items)