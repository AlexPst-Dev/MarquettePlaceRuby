class UsersController < ApplicationController
  before_action :require_login, only: [:toggle_role]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created!'
    else
      render :new
    end
  end

  def toggle_role
    if current_user.buyer?
      current_user.update(role: :seller)
      flash[:notice] = "You are now a seller."
    else
      flash[:notice] = "You are already a seller."
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
