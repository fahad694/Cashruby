class Order < ApplicationRecord
  has_many   :order_items
  # belongs_to :user
  validates  :customer_id, presence: true
  # validates  :discount_percentage
end