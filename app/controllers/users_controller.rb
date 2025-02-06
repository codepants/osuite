class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:reset_password, :update_password]
  before_action :require_admin!, except: [:reset_password, :update_password]  # Allow password reset without admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:name)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to users_path, alert: 'Cannot delete yourself.'
    else
      @user.destroy
      redirect_to users_path, notice: 'User was successfully deleted.'
    end
  end

  def profile
    skip_before_action :require_admin!, only: [:profile]
    @user = current_user
  end

  def reset_password
    
    @token = params[:token]
    # p @token
    # 
    # In a real app, you'd verify the token's validity
    # For demo purposes, we'll just show the password reset form
    render :reset_password
  end

  def update_password
    @user = User.find_by(email: params[:email])
    
    if @user && params[:password] == params[:password_confirmation]
      if @user.update(password: params[:password])
        # Log the user in
        session[:user_id] = @user.id
        redirect_to dashboard_path, notice: 'パスワードが正常に更新されました。'
      else
        flash.now[:alert] = 'パスワードの更新中にエラーが発生しました。'
        render :reset_password
      end
    else
      flash.now[:alert] = 'パスワードが一致しません。'
      render :reset_password
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end 