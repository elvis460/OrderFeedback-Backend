class DeliveryOrder < ApplicationRecord
  has_many :order_items

  validates :order_id, uniqueness: true

end
