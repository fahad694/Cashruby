class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item, class_name: 'Item', foreign_key: 'item_id'
  has_one    :line_item
  validates  :quantity, numericality: { greater_than: 0 }
  validates  :item_id, :order_id, presence: true
  validates  :price, numericality: { greater_than_or_equal_to: 0}

end