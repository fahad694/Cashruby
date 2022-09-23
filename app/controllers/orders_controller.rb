class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @user = User.first
    binding.pry
    @order = Order.create(customer_id: @user.id)
    redirect_to order_path(@order)
  end
  
  def show
    @order = Order.find(params[:id])
    @items = Item.all
  end

  def commit_order
    binding.pry
  end

end