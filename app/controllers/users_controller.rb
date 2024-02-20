class UsersController < ApplicationController

  def show
    @current_user = current_user
    @interests = Interest.all
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

  def user_interests
    @user = User.find(params[:id])
    @user_interests = @user.interests
    @interests = Interest.all
  end


  def add_interest
    @user = User.find(params[:id])
    @user.interests << Interest.find(params[:interest_id])
    redirect_to @user

    @user = User.find(params[:id])
    @interest = Interest.find(params[:interest_id])
    @user.interests << @interest
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@interest) }
      format.html { redirect_to @user }
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :profile_image, :about)
    end
end
