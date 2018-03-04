class Feedback < ApplicationRecord
  belongs_to :ratable, :polymorphic => true

  validates :ratable_id, :ratable_type, :rating, presence: true
end
