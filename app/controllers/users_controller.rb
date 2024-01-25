class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      puts "User saved to Database!"
      redirect_to new_user_sessions_path
    else
      render :new
    end

  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :profile_image)
    end

end
