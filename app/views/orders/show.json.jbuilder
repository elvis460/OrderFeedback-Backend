json.order do
  json.order_id @order.order_id
  json.delivery_date @order.serving_datetime.strftime('%F')
  json.delivery_time show_delivery_time(@order.serving_datetime)

  json.order_items @order.order_items do |item|
    json.name item.meal.name
    json.quantity item.quantity
    json.total_price cal_total_price(item)
  end
end

