class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_item, only: [:show, :edit, :update, :destroy ]
  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/new
  def new
    @categories = Category.all
    @subcategories = SubCategory.all
    @item = Item.new
  end

  # POST /items
  def create
    @item = Item.create(item_params)
    if @item.valid?
      redirect_to items_path()  
    end
    
  end

  # GET /items/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  #  GET /items/:id/edit
  def edit
    @categories = Category.all
    @subcategories =  SubCategory.all
  end

  #  PATCH/PUT /items/:id
  def update
    Category.all
    SubCategory.all
    @item.update(item_params)
    if @item.valid?
      redirect_to items_path()  
    end
  end

  # DELETE /items/:id
  def destroy
    @item.destroy
    redirect_to items_path
  end

 private

  def load_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :quantity, :price, :sub_category_id, :category_id)
  end  
end
