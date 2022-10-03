class OrdersController < ApplicationController
  before_action :load_order, only: [  :show, :remove_item, :payment, :commit_order ]
  
  # GET /orders/new
  def new
    @order = Order.new
  end

  # POST /orders
  def create
    @user = User.first
    @order = Order.create(customer_id: @user.id)
    redirect_to order_path(@order)
  end
  
  # GET /orders/:id 
  def show
    @order_item = OrderItem.find(params[:order_item_id])
  end

  # POST /orders
  def add_item
    ActiveRecord::Base.transaction do
      item_id = params["items"]["0"]
      order_id = params["id"]
      item = Item.find(item_id)
      item_price = item.price
      @order_item = OrderItem.new(item_id: item_id, order_id: order_id, price: item_price, quantity: params["quantity"].to_i)
      @order_item.save!
      @order.recalculate_total_price
      redirect_to order_path(@order)
    end
  rescue ActiveRecord::RecordInvalid
    puts "Error!"
  end

  # Delete /orders/:id
  def remove_item
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy
    redirect_to order_path(params[:id])
  end

  # POST /orders
  def charge_payment
    ActiveRecord::Base.transaction do
      @payment = Payment.create(order_id: params[:id], paid_amount: params[:paid_amount])
      @order.recalculate_paid_amount
      redirect_to order_path(params[:id])
    end
  rescue ActiveRecord::RecordInvalid
    puts "Payment Error!"
  end
  private

  def load_order
    @order = Order.find(params[:id])
  end

end