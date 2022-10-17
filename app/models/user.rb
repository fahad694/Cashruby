class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :validatable
  has_many  :orders, foreign_key: 'customer_id', dependent: :restrict_with_error
  validates :name, :password, :email, :address, :phone, presence: true
  validates :email, uniqueness: true

  def admin?
    role == 'admin'
  end
  
  def owner?
    role == 'owner'
  end

  def customer?
    role == 'customer'
  end
end
