json.orders @orders do |order|
  json.order_id order.order_id
  json.delivery_date order.serving_datetime.strftime('%F')
  json.delivery_time show_delivery_time(order.serving_datetime)
end