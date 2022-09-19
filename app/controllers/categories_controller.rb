class CategoriesController < ApplicationController
  def new
  	@category = Category.new
  end
  def create

  	@category = Category.create(category_params)
    redirect_to categories_path
  end
  def index
    @category = Category.all
    
  end
  def category_params
    params.require(:category).permit(:title)
  end

  def show
    @category = Category.find(params[:id])
  end
  def edit
    @category = Category.find(params[:id])
    render :edit
  end
  def update
    @category = Category.find(params[:id])
    @category = @category.update(category_params)
    redirect_to categories_path
  end
end


