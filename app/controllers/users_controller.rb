class UsersController < ApplicationController
  
  #  GET /users/new
  def new
    @user = User.new
    authorize(@user)
    respond_to do |format|
      format.html
    end
  end

  # POST /users
  def create_user
    @user = User.new(user_params)
    authorize(@user)
    @user.role = 'admin'
    if @user.save
      flash[:notice] = 'successfull created'
      redirect_to users_path
    else
      flash[:notice] = @user.errors.full_messages
      render :new
    end
  end

  def user_profile
    respond_to do |format|
      format.html
    end
  end

  # GET /users
  def index
    @users = User.all
    authorize(@users)
    respond_to do |format|
      format.html
    end
  end

  private
  def user_params
    binding.pry
    params.require(:user).permit( :name, :email, :password, :address, :phone, :date_of_birth, :gender )
  end
end
