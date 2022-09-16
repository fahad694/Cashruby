class LineItem < ApplicationRecord
	belongs_to :item
	belongs_to :order_item
	validates  :quantity, :numaricality => {greater_than:0}
end