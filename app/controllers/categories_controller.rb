class CategoriesController < ApplicationController
  def new
  	@category = Category.new
 
  end
  def create
  	@create = Category.create

  end
end