class UserSessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      @url = session[:fall_back_url]
      if @url
        session[:fall_back_url] = nil
        redirect_to @url
      else
        if @user.interests.count <= 3
          redirect_to user_interests_path(id: @user.id)
        else
          redirect_to root_path
        end
      end
    else
      redirect_to new_user_sessions_path
    end
  end

  def destroy
    puts "======================Destroy========================="
    session[:user_id] = nil
    redirect_to root_path
  end

end
