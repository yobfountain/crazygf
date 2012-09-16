class HomeController < ApplicationController
  
  def index
  end
  
  def stats
    @users = User.active_users
    @inactive_user_count = User.all.size - @users.size
  end
  
end