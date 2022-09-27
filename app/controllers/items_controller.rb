class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_category, only: [:remove_stock, :show, :add_stock, :edit, :update, :destroy]
  def index
    @items = Item.all
  end
  def new
    @categories = Category.all
    @subcategories = SubCategory.all
    @item = Item.new
  end
  def create
    @item = Item.create(item_params) 
    @lineitem = LineItem.create(quantity: params.dig(:item, :quantity), item_id:@item.id)
    @item.recalculate_current_quantity
    redirect_to items_path()
    

  end
  def show
  @lineitems = LineItem.all    
  end

  def add_stock
    
    LineItem.create(quantity: params[:quantity], item_id: params[:id])
    @item.recalculate_current_quantity
    redirect_to items_path
  end
  def remove_stock
    item_quantity = params[:quantity]
    item_quantity = item_quantity.to_i
    item_quantity *= -1
    item_quantity = item_quantity.to_s
    params[:quantity] = item_quantity
    LineItem.create(quantity: item_quantity, item_id: params[:id])
    @item.recalculate_current_quantity
    redirect_to items_path
  end
  
  def edit
    
    @categories = Category.all
    @subcategories =  SubCategory.all
  end

  def update
    
    @categories = Category.all
    @subcategories =  SubCategory.all
    @item.update(item_params)
    redirect_to items_path
  end
  def destroy
    
    @item.destroy
    redirect_to items_path
  end


  def search
    params_str = params[:q] 
    data = Item.where('name LIKE ?', "%#{params_str}%")
    data = data.collect { |item| {id: item.id, name: item.name } }
    respond_to do |format|
      format.json do
        render json: data, status: :ok
      end
    end
  end

 private
 
def load_category
    @item = Item.find(params[:id])
  end

  def item_params
      params.require(:item).permit(:name, :price, :sub_category_id, :category_id)
  end  
end
