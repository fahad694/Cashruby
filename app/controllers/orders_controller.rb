class OrdersController < ApplicationController
  before_action :load_order, only: [  :show, :remove_item, :charge_payment, :add_item ]
  
  # GET /orders/new
  def new
    @order = Order.new
    respond_to do |format|
      format.html
    end
  end

  # POST /orders
  def create
    @user = User.first
    @order = Order.create!( customer_id: @user.id, state: "cart" )
    if @order.valid?
      flash[:notice] = 'successfull Created'
      redirect_to order_path(@order)
    else
      flash[:notice] = @order.errors.full_messages
      render :new  
    end
  end

  # GET /orders
  def index
    @orders = Order.all.includes(:user)
    respond_to do |format|
      format.html
    end
  end
  
  # GET /orders/:id 
  def show
    @order_items = @order.order_items
    respond_to do |format|
      format.html
    end
  end

  # POST /orders/:id/add_item 
  def add_item
    valid = true
    begin
      ActiveRecord::Base.transaction do
        item_id = params.dig(:items, '0')
        order_id = params["id"]
        item = Item.find(item_id)
        item_price = item.price
        @order_item = OrderItem.create!(item_id: item_id, order_id: order_id, price: item_price, quantity: params["quantity"].to_i)
        @order.recalculate_total_price
      end
    rescue ActiveRecord::RecordInvalid => e
    valid = false
    errors = [e.message]
    end
    if valid
      flash[:message] = 'Item successfully added'
      redirect_to order_path(@order)
    else
      flash[:notice] = errors
      render :show
    end
  end

  # Delete /orders/:id
  def remove_item
    @order_item = OrderItem.find(params[:order_item_id])
    @order_item.destroy!
    if @order_item.destroyed?
      flash[:notice] = 'successfully Deleted'
      @order.recalculate_total_price
      redirect_to order_path(@order)
    else
      flash[:errors] = @order.errors.full_messages
      redirect_to order_path(@order)
    end
    
  end

  # POST /orders
  def charge_payment
    valid = true
    begin
      ActiveRecord::Base.transaction do
        @payment = Payment.create(order_id: params[:id], paid_amount: params[:paid_amount])
        @order.recalculate_paid_amount
      end
    rescue ActiveRecord::RecordInvalid => e
      valid = false
      errors = [e.message]      
    end

    if valid
      flash[:notice] = 'Payment successfull'
      redirect_to order_path(@order)
    else
      flash[:notice] = errors
      render :show 
    end
  end
  private

  def load_order
    @order = Order.find(params[:id])
  end
end
