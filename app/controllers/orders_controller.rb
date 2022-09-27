class OrdersController < ApplicationController
  before_action :load_id, only: [:commit_order, :show, :remove_item, :payment]
  def new
    @order = Order.new
  end

  def create
    @user = User.first
    @order = Order.create(customer_id: @user.id)
    redirect_to order_path(@order)
  end
  
  def show
    @items = Item.all
    @order_items = OrderItem.all
  end

  def commit_order
    item_id = params["items"]["0"]
    order_id = params["id"]
    item_price = Item.find(item_id)
    item_price = item_price.price
    @order_item = OrderItem.new
    @order_item.item_id = item_id
    @order_item.order_id = order_id
    @order_item.price = item_price
    @order_item.quantity = params["quantity"].to_i
    @order_item.save!
    @order.recalculate_total_price
    redirect_to order_path(@order)
  end
  def remove_item
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy
    redirect_to order_path(params[:id])
  end

  def payment
    
    @payment = Payment.create(order_id: params[:id], paid_amount: params[:paid_amount])
    @order.recalculate_paid_amount
    # Order.update(paid_amount: params[:paid_amount])
    redirect_to order_path(params[:id])
  end
  private
def load_id
  @order = Order.find(params[:id])
end

end