class SubCategoriesController < ApplicationController
  before_action :load_sub_category, only: [ :show, :edit, :update, :destroy ] 
  
  # GET /sub_categories/new
  def new
    @categories = Category.all
    @sub_category = SubCategory.new
    authorize(@sub_category)
    respond_to do |format|
      format.html
    end
  end

  # POST /sub_categories
  def create
    @sub_category = SubCategory.create!(sub_category_params)
    if @sub_category.valid?
      flash[:notice] = 'successfull created'
      redirect_to sub_categories_path
    else
      flash[:errors] = @sub_category.errors.full_messages
      render :new
    end  
  end
  
  # GET /sub_categories
  def index
    @sub_categories = SubCategory.includes(:category).all
    authorize(@sub_categories)
    respond_to do |format|
      format.html
    end
  end

  # GET /sub_categories/:id 
  def show
    authorize(@sub_category)
    respond_to do |format|
      format.html
    end
  end

  #  GET /sub_categories/:id/edit
  def edit
    authorize(@sub_category)
    @categories = Category.all
  end

  # PATCH/PUT /subcategories
  def update
    @sub_category.update!(sub_category_params)
    if @sub_category.valid?
      flash[:notice] = 'successfull updated'
      redirect_to sub_categories_path 
    else
      flash[:notice] = @sub_category.errors.full_messages
      render :edit
    end
  end

  # DELETE /subcategories/:id
  def destroy
    authorize(@sub_category)
    @sub_category.destroy
    if @sub_category.valid?
      flash[:notice] = 'successfull deleted'
      redirect_to sub_categories_path
    else
      flash[:notice] = @sub_category.errors.full_messages
      redirect_to sub_categories_path
    end  
  end

  private

  def load_sub_category
    @sub_category = SubCategory.find(params[:id])
  end

  def sub_category_params
    params.require(:sub_category).permit(:title,:category_id)
  end
end
