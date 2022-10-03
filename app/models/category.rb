class Category < ApplicationRecord
  has_many  :sub_categories, dependent: :restrict_with_error
  has_many  :items
  validates :title, presence: true
  
end
