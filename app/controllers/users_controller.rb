class UsersController < ApplicationController
  before_action :load_user, only:[ :edit, :update, :destroy ]
  
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
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # get /users/:id
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

  # GET /users/:id/edit
  def edit
    respond_to do |format|
      format.html
    end
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update!
      flash[:notice] = 'successfull Updated'
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    if @user.destroy
      flash[:notice] = 'successfull Deleted'
      redirect_to users_path
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private
  def load_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit( :name, :email, :password, :address, :phone, :date_of_birth, :gender )
  end
end
