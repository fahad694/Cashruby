class Payment < ApplicationRecord
  belongs_to :order
  validates :order_id, presence: true
  validates :paid_amount, numericality: { greater_than_or_equal_to: 0}

end
