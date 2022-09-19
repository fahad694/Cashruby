class SubCategory < ApplicationRecord
  belongs_to :category
  has_many   :items
  validates  :title, :category_id, presence: true
end