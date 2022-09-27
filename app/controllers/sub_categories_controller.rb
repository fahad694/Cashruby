class SubCategoriesController < ApplicationController
  before_action :load_Subcategory, only: [:show, :edit, :update, :destroy] 
  # GET subcategory
  def new
    @categories = Category.all
    @subcategory = SubCategory.new
  end

  # POST create subcategory
  def create
    @subcategory = SubCategory.create(sub_category_params)
    redirect_to sub_categories_path()  
  end
  
  # GET show all subcategory
  def index
    @subcategories = SubCategory.all
  end

  # GET show subcategory 
  def show
  end

  #  GET subcategory
  def edit
    @categories = Category.all
  end

  # PATCH/PUT subcategory
  def update
    @categories = Category.all
    @subcategory.update(sub_category_params)
    redirect_to sub_categories_path()
  end

  # DELETE subcategory
  def destroy
    @subcategory.destroy
    redirect_to sub_categories_path
  end
  private

  # load subcategory
  def load_Subcategory
    @subcategory = SubCategory.find(params[:id])
  end

  # strong parameter for create
  def sub_category_params
    params.require(:sub_category).permit(:title,:category_id)
  end
  
end