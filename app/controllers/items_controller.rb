class ItemsController < ApplicationController
  def index

    @items = Item.all
    @order = Order.first
  	respond_to do |format|
  	  format.html
  	end
  end
end
