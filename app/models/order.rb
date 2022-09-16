class Order < ApplicationRecord
	has_many   :order_items
	belongs_to :user
	validates  :customer_id, :total_price, presence: true
end