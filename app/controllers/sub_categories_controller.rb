class SubCategoriesController < ApplicationController
  before_action :load_Subcategory, only: [:show, :edit, :update, :destroy] 
  
  # GET /sub_categories/new
  def new
    @categories = Category.all
    @sub_category = SubCategory.new
  end

  # POST /sub_categories
  def create
    @sub_category = SubCategory.create(sub_category_params)
    redirect_to sub_categories_path()  
  end
  
  # GET /sub_categories
  def index
    @sub_categories = SubCategory.all
  end

  # GET /sub_categories/:id 
  def show
  end

  #  GET /sub_categories/:id/edit
  def edit
    @categories = Category.all
  end

  # PATCH/PUT /subcategories
  def update
    @sub_category.update(sub_category_params)
    redirect_to sub_categories_path()
  end

  # DELETE /subcategories/:id
  def destroy
    @sub_category.destroy
    redirect_to sub_categories_path
  end

  private
  def load_Subcategory
    @sub_category = SubCategory.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:title,:category_id)
  end
  
end