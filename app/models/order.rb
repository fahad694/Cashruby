class Order < ApplicationRecord
  has_many   :order_items, dependent: :destroy
  has_many   :payments, dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'customer_id'
  validates  :customer_id, presence: true
  # validates  :discount_percentage, numericality: { greater_than_or_equal_to: 0, less_than_equal_to: 100}
  
  def recalculate_total_price
    total_price = order_items.map{|order_item| order_item.price * order_item.quantity}.sum
    self.update(total_price: total_price)
  end

  def recalculate_paid_amount
    calculated_paid_amount = payments.sum(:paid_amount)
    self.update(paid_amount: calculated_paid_amount)
  end

end
