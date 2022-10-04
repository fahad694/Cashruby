class ItemsController < ApplicationController
  before_action :load_item, only: [ :show, :edit, :update, :destroy, :add_stock, :remove_stock ]

  # GET /items
  def index
    @items = Item.all.includes(:category, :sub_category)
    respond_to do |format|
      format.html
    end
  end

  # GET /items/new
  def new
    @item = Item.new
    load_data_for_form
    respond_to do |format|
      format.html
    end
  end

  # POST /items
  def create
    valid = true
    begin
      ActiveRecord::Base.transaction do 
        @item = Item.new(item_params)
        @item.quantity = 0
        @item.save!
        @line_item = LineItem.create!(quantity: params.dig(:item, :quantity), item_id:@item.id)
        
        @item.recalculate_current_quantity!
      end
    rescue ActiveRecord::RecordInvalid => e
      valid = false
      errors = [e.message]
    end
    if valid
      flash[:notice] = 'Item has been created!'
      redirect_to item_path(@item)
    else
      load_data_for_form
      flash[:error] = errors
      render :new
    end
  end

  # GET /items/:id
  def show
    @line_items = @item.line_items 
    respond_to do |format|
      format.html
    end
  end

  # POST /items/:id
  def add_stock
    valid = true
    begin
      ActiveRecord::Base.transaction do 
        LineItem.create!(quantity: params[:quantity], item_id: @item.id)
        @item.recalculate_current_quantity!
      end
    rescue ActiveRecord::RecordInvalid => e
    valid = false
    errors = [e.message]
    end

    if valid
      flash[:notice] = 'stock has been added'
      redirect_to items_path
    else
      flash[:errors] = errors
      redirect_to items_path
    end
  end

  #  DELETE /items/:id
  def remove_stock
    valid = true
    begin
      ActiveRecord::Base.transaction do
        item_quantity = params[:quantity].to_i * -1
        LineItem.create!(quantity: item_quantity, item_id: params[:id])
        @item.recalculate_current_quantity!
      end
    rescue ActiveRecord::RecordInvalid => e
      valid = false
      errors = [e.message]    
    end

    if valid
      flash[:notice] = 'stock has been removed'
      redirect_to items_path
    else
      flash[:notice] = errors
      render :show
    end
  end

  # GET /items/:id/edit
  def edit
    load_data_for_form
  end

  # PATCH/PUT /items/:id
  def update
    @item.update!(item_params)
    if @item.valid?
      flash[:notice] = 'Item has been Updated'
      redirect_to items_path
    else
      load_data_for_form
      flash[:notice] = @item.errors.full_messages
      render :edit
    end
  end

  # DELETE /items/:id
  def destroy  
    @item.destroy
    if @item.destroyed?
      flash[:notice] = 'Item successfully Deleted'
      redirect_to items_path
    else
      flash[:errors] = @item.errors.full_messages
      redirect_to items_path
    end
  end

  # GET /items/search
  def search
    params_str = params[:q] 
    filtered_items = Item.where('name LIKE ?', "%#{params_str}%")
    filtered_items = filtered_items.collect { |item| {id: item.id, name: item.name } }
    respond_to do |format|
      format.json do
        render json: filtered_items, status: :ok
      end
    end
  end

  private
 
  def load_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit( :name, :price, :sub_category_id, :category_id )
  end  

  def load_data_for_form
    @categories = Category.all
    @sub_categories = SubCategory.all
  end
end
