class Item < ApplicationRecord
	belongs_to :category
	belongs_to :sub_category
	has_many   :order_items
	has_many   :line_items
	validates  :name, :price, :quantity, presence: true
end