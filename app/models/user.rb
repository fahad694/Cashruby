class User < ApplicationRecord
  has_many  :orders, dependent: :destroy
  validates :name, :email, :address, :phone, presence: true
  validates :email, uniqueness: true
end
