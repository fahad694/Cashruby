class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_item, only: [ :show, :edit, :update, :destroy, :add_stock, :remove_stock ]
  
  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/new
  def new
    @categories = Category.all
    @sub_categories = SubCategory.all
    @item = Item.new
  end

  # POST /items
  def create
    ActiveRecord::Base.transaction do 
      @item = Item.create!(item_params) 
      @line_item = LineItem.create!(quantity: params.dig(:item, :quantity), item_id:@item.id)
      @item.recalculate_current_quantity
    end
  rescue ActiveRecord::RecordInvalid
      puts "an error to create item"
    redirect_to items_path()  
  end

  # GET /items/:id
  def show
    @line_items = LineItem.all 
  end

  # POST /items/:id
  def add_stock
    ActiveRecord::Base.transaction do 
      LineItem.create(quantity: params[:quantity], item_id: @item.id)
      @item.recalculate_current_quantity
      redirect_to items_path
    end
  rescue ActiveRecord::RecordInvalid
    puts "line item!"
  end

  #  DELETE /items/:id
  def remove_stock
    ActiveRecord::Base.transaction do
      item_quantity = params[:quantity].to_i * -1
      LineItem.create(quantity: item_quantity, item_id: params[:id])
      @item.recalculate_current_quantity
      redirect_to items_path
    end
  rescue ActiveRecord::RecordInvalid
    puts "remove item!"
  end
  
  # GET /items/:id/edit
  def edit
    @categories = Category.all
    @sub_categories =  SubCategory.all
  end

  # PATCH/PUT /items/:id
  def update
    @categories = Category.all
    @sub_categories =  SubCategory.all
    @item.update!(item_params)
    redirect_to items_path
  end

  # DELETE /items/:id
  def destroy  
    @item.destroy
    redirect_to items_path
  end

  # GET /items
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
end
