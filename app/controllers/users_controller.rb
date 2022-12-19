class UsersController < ApplicationController

  #  GET /users/new
  def new
    @user = User.new
      respond_to do |format|
        format.html
      end
  end

  # POST /users
  def create
    @user = User.create!(user_params)
    if @user.valid?
      flash[:notice] = 'successfull created'
      redirect_to users_path
    else
      flash[:notice] = @user.errors.full_messages
      render :new
    end
  end

  # GET /users
  def index
    @users = User.all
    respond_to do |format|
      format.html
    end
  end

  private
  def user_params
    params.require(:user).permit( :name, :email, :password, :address, :phone, :date_of_birth, :gender )
  end
end
