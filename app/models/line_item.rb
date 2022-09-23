class LineItem < ApplicationRecord
  belongs_to :item
  belongs_to :order_item
  validates  :quantity, numericality: {greater_than_or_equal_to: 0}

end