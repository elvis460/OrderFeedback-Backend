json.orders @orders do |order|
  json.id order.id
  json.order_id order.order_id
  json.delivery_date order.serving_datetime.strftime('%F')
  json.delivery_time show_delivery_time(order.serving_datetime)
  json.feedback_submitted feedback_status(order)

  json.order_items order.order_items do |item|
    json.order_item_id item.id
    json.name item.meal.name
  end
end
