class Order < ApplicationRecord
  has_many   :order_items, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'customer_id'
  validates  :customer_id, presence: true
  validates  :discount, numericality: { greater_than_or_equal_to: 0, less_than_equal_to: 100}

end