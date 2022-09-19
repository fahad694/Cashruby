class Item < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  has_many   :order_items
  has_many   :line_items
  validates  :name, presence: true
  validates  :quantity, numericality => { greater_than: 0 }
  validates  :price, numericality => { greater_than_or_equal_to: 0}
end