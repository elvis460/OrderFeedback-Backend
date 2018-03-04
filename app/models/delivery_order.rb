class DeliveryOrder < ApplicationRecord
  has_many :order_items
  has_one :feedback, :as => :ratable

  validates :order_id, uniqueness: true, presence: true

end
