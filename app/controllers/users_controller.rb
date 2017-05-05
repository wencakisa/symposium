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

    if @user.save
      flash[:success] = 'You have successfully registered.'
      redirect_to @user
    else
      render 'new', errors: @user.errors.full_messages
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
