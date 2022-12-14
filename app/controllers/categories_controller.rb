class CategoriesController < ApplicationController
  before_action :load_category, only: [ :show, :edit, :update, :destroy ]
  
  # GET /categories/new
  def new
    @category = Category.new
    respond_to do |format|
      format.html
    end
  end

  # POST /categories
  def create
    @category = Category.create(category_params)
    if @category.valid?
      flash[:notice] = 'Category has been created!'
      redirect_to category_path(@category)
    else
      flash[:error] = @category.errors.full_messages
      render :new
    end
  end

  # GET /categories
  def index
    @categories = Category.all
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /categories/:id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH /categories/:id
  def update
    @category.update(category_params)
    if @category.valid?
      flash[:notice] = 'Category has been updated!'
      redirect_to category_path(@category)
    else
      flash[:error] = @category.errors.full_messages
      render :edit
    end
  end

  # Delete /Categories/:id
  def destroy
    @category.destroy
    if @category.destroyed?
      flash[:notice] = 'successfull deleted'
      redirect_to categories_path
    else
      flash[:notice] = @category.errors.full_messages
      redirect_to categories_path   
    end
  end

  private

  def load_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title)
  end
end
