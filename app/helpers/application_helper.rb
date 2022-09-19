module ApplicationHelper
	def display_price(amount)
		"Rs. #{amount.to_d}"
	end
end
