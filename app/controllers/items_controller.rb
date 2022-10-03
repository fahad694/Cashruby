class ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :load_item, only: [:show, :edit, :update, :destroy ]
  # GET /items
  def index
    @items = Item.all
  
    respond_to do |format|
      format.html
    end
  end

  # GET /items/new
  def new
    @item = Item.new
    load_data_for_form

    respond_to do |format|
      format.html
    end
  end

  # POST /items
  def create
    @item = Item.create(item_params)
    if @item.valid?
      flash[:notice] = 'Item has been created!'
      redirect_to item_path(@item)
    else
      load_data_for_form
      flash[:error] = @item.errors.full_messages
      render :new
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
    load_data_for_form
  
    respond_to do |format|
      format.html
    end
  end

  #  PATCH/PUT /items/:id
  def update
    @item.update(item_params)
    

    if @item.valid?
      flash[:notice] = 'Item has been updated!'
      redirect_to item_path(@item)
    else
      load_data_for_form
      flash[:error] = @item.errors.full_messages
      render :edit
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

  def load_data_for_form
    @categories = Category.all
    @sub_categories = SubCategory.all
  end
end
