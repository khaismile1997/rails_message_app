# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i(show)
  before_action :set_password_form, only: %i(change_password update_password)
  before_action :require_user, only: %i(change_password update_password)

  def show; end

  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return render "new" unless @user.save
    session[:user_id] = @user.id
    flash[:notice] = "Welcome to Message App #{@user.username}! You have successful signup!"
    redirect_to root_path
  end

  def change_password; end

  def update_password
    if @pass_form.submit(password_params)
      flash[:notice] = "Password successfully changed!"
      redirect_to root_path
    else
      render "change_password"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_password_form
    @pass_form = ChangePasswordForm.new(current_user)
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def password_params
    params.require(:change_password_form).permit(:old_password, :password, :password_confirmation)
  end
end
