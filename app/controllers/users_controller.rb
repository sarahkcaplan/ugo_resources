class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_type = params[:user_type]
    if @user.save
      session[:id] = @user.id
      redirect_to user_path(@user), notice: "User was successfully created."
    else
      @errors = @user.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to sessions_path, notice: "User was successfully destroyed."
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :user_type)
  end

end
