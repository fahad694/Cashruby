class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
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
    redirect_to items_path()
  end
  def show
    @item = Item.find(params[:id])
  end
  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    @subcategories =  SubCategory.all
  end
  def update
    @item = Item.find(params[:id])
    @categories = Category.all
    @subcategories =  SubCategory.all
    @item.update(item_params)
    redirect_to items_path
  end
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end
 private
  def item_params
      params.require(:item).permit(:name, :quantity, :price, :sub_category_id, :category_id)
  end  
end
