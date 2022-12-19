require 'rails_helper'

RSpec.describe Order, type: :model do
  before do 
    @category = Category.create!(title: 'Electronic')
    @sub_category = SubCategory.create!(category: @category, title: 'Mobile-phone')

    @user = User.create!(name: 'fahad tariq', email: 'fahad.new@gmail.com', address: 'lahore', phone: '03034831068', date_of_birth: Time.zone.now - 10.years, gender: 'male', type: 'User')
    @item = Item.create!(category: @category, name: 'khoye wali kulfy', sub_category: @sub_category, price: 200)
    @order = Order.create!( customer_id: @user.id, state: "cart")
  end

  context 'creation order' do
    it 'order created successfully' do
      expect(@order.state).to eq 'cart'
    end
  end

  context 'test to order price amount' do
    before do
  	  @order_item = OrderItem.create!(item_id: @item.id, order_id: @order.id, price: @item.price, quantity: 4)
  	end

    it 'recalculate_total_price' do
      @order.recalculate_total_price
  	  expect(@order.total_price).to eq 800
    end
  end
end