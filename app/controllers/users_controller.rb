class UsersController < ApplicationController

  def show
    @current_user = current_user
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    # Check if the typed password matches the old password
    if current_user.authenticate(params[:user][:password])
      if @user.update(user_params)
        redirect_to app_path
      else
        render :edit
      end
    else
      flash[:notice] = "Password is incorrect."
      render :edit
    end
    end

  private
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :profile_image, :about)
    end
end
