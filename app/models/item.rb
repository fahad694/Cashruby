class Item < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  has_many   :order_items
  has_many   :line_items
  validates  :name, :category_id, :sub_category_id, presence: true
  validates  :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates  :price, numericality: { greater_than_or_equal_to: 0}

  def recalculate_current_quantity 
    x = line_items.pluck(:quantity).sum
    self.update(quantity: x)
  end
end