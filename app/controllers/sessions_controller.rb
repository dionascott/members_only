class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "You are signed in."
      sign_in user
      redirect_to posts_path
    else
      flash.now[:alert] = "Incorrect password/email."
      render 'new'
    end
  end

  def destroy
    if current_user
      sign_out
      flash.now[:success] = "You are signed out."
      render 'new'
    else
      flash.now[:alert] = "You are already signed out."
      render 'new'
    end
  end
end
