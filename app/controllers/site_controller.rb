class SiteController < ApplicationController
  def home
    if logged_in?
      redirect_to :controller => 'users', :action => 'show', :id => session[:user_id]
    else
      redirect_to login_url
    
    end
  end

  def about
  end

  def contact
  end
end
