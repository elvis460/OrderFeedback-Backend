class OrderItem < ApplicationRecord
  belongs_to :meal
  has_one :feedback, :as => :ratable

end
