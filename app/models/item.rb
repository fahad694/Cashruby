class Item < ApplicationRecord
  belongs_to :category
  belongs_to :sub_category
  has_many   :order_items, dependent: :restrict_with_error
  has_many   :line_items, dependent: :destroy
  validates  :name, :category_id, :sub_category_id, presence: true
  validates  :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates  :price, numericality: { greater_than_or_equal_to: 0 }

end
