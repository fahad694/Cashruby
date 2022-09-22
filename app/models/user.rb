class User < ApplicationRecord
	has_many :orders
	validates :name, :password, :email, :address, :phone, presence: true
  validates :email, uniqueness: true
end