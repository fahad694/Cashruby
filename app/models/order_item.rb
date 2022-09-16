class OrderItem < ApplicationRecord
	belongs_to :order, dependent: :destroy
	belongs_to :item
	has_one    :line_item
	validates  :quantity, :numaricality => {greater_than: 0}
	validates  :Item_id, :order_id, presence: true


end