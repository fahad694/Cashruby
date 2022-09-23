class SubCategoriesController < ApplicationController

  def new
    @categories = Category.all
    @subcategory = SubCategory.new
  end

  def create
    @subcategory = SubCategory.create(sub_category_params)
    redirect_to sub_categories_path()  
  end
  
  def index
    @subcategories = SubCategory.all
  end

  def show
    @subcategory = SubCategory.find(params[:id])

  end

  def edit
    @subcategory = SubCategory.find(params[:id])
    @categories = Category.all
  end

  def update
  @categories = Category.all
  @subcategory = SubCategory.find(params[:id])
  @subcategory.update(sub_category_params)
    redirect_to sub_categories_path()
  end
  def destroy
    @subcategory = SubCategory.find(params[:id])
    @subcategory.destroy
    redirect_to sub_categories_path
  end
  private

  def sub_category_params
    params.require(:sub_category).permit(:title,:category_id)
  end
end