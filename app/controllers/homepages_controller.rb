class HomepagesController < ApplicationController

  def index
  end

  def destroy
    session[:user_id] = nil
    puts "======================Destroy========================="
    redirect_to root_path, notice: 'Logged out successfully!'
  end

end
