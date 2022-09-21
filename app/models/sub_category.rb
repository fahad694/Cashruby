class SubCategory < ApplicationRecord
  belongs_to :category
  has_many   :items, dependent: :restrict_with_error
  validates  :title, :category_id, presence: true
end