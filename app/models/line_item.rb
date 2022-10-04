class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :order_item, optional: true
  validates  :quantity, numericality: { greater_than_or_equal_to: 0 }
end
