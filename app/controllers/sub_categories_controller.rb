class SubCategoriesController < ApplicationController

  def new
    @categories = Category.all
    @sub_category = SubCategory.new
  end

  def create
    @sub_category = SubCategory.create(sub_category_params)
    redirect_to sub_categories_path()  
  end
  
  def index
    @sub_categories = SubCategory.includes(:category).all
  end

  def show
    @sub_category = SubCategory.find(params[:id])

  end

  def edit
    @sub_category = SubCategory.find(params[:id])
    @categories = Category.all
  end

  def update
  @sub_category = SubCategory.find(params[:id])
  @sub_category.update(sub_category_params)
  redirect_to sub_categories_path()
  end
  def destroy
    @sub_category = SubCategory.find(params[:id])
    @sub_category.destroy
    redirect_to sub_categories_path
  end
  private

  def sub_category_params
    params.require(:sub_category).permit(:title,:category_id)
  end
end