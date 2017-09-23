module ApplicationHelper
  def sign_in(user)
    # assign new remember_token
    remember_token = User.new_token
    #store remember_token in browser cookie cookies.permanent
    cookies.permanent[:remember_token] = remember_token
    remember_digest = User.digest(remember_token)
    user.update_attribute(:remember_digest, remember_digest)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by(remember_digest: User.digest(cookies[:remember_token]))
  end

  def current_user=(user)
    @current_user = user
  end

  def sign_out
    @current_user = nil
    cookies.permanent[:remember_token] = nil
  end

  def signed_in
    if !current_user
      redirect_to login_path
      flash[:alert] = 'Please login to create posts'
    end
  end

  def signed_in?
    if !current_user
      return false
    else
      return true
    end
  end


end
