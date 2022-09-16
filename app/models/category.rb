class Category < ApplicationRecord
	has_many :sub_categories
	has_many :items
	validates :title, presence: true
end