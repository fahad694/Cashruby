class Order < ApplicationRecord
  has_many   :order_items, dependent: :destroy
  belongs_to :user
  validates  :customer_id, presence: true
  validates  :discount, numericality => { greater_than: 0, less_than_equal_to: 100}
end