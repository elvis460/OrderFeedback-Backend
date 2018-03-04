module OrdersHelper
  # assume delivery_time is in the range 30 minutes of delivery_time
  def show_delivery_time(serving_datetime)
    "#{serving_datetime.strftime('%R')} - #{(serving_datetime+30*60).strftime('%R')} #{serving_datetime.strftime('%p')}"
  end

  def cal_total_price(item)
    item.quantity * item.unit_price
  end

  def feedback_status(order)
    order.feedback.present?
  end
end
