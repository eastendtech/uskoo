module SessionsHelper

  #Set session cookie: 
  def log_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  #Returns the current logged-in user (if any) 
  def current_user 
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def current_user?(user)
    user == current_user
  end  
  

  # Forgets a persistent session.
  def forget(user)
    #user.forget
    cookies.delete(:user_id)
    #cookies.delete(:remember_token)
  end
  
  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

   def signed_in_user
    unless logged_in?
      store_location
      redirect_to login_url, notice: "Please log in."
    end
  end


  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
  
  def redirect_back_or(default, *more)
    redirect_to(session[:return_to] || default, *more)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end


end
