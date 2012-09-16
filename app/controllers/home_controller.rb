class HomeController < ApplicationController
  
  def index
  end
  
  def stats
    @users = User.all
  end
  
end