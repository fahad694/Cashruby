class UsersController < ApplicationController

def new
  @user = User.new
  respond_to do |format|
      format.html
    end
end

def create
  binding.pry
  @user = User.create(load_params)
end
def index
  @users = User.all
end

private
 def load_params
   params.require(:user).permit(:name, :emai, :password, :address, :phone, :date_of_birth, :gender, :type)
 end
end