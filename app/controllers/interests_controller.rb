class InterestsController < ApplicationController
  # allow only authenticated user to access these pages
  before_action :authenticate_user

  before_action :set_interest

  def update
    if @user.has_interest?(@interest.name)
      @user.remove_interest(@interest)
      puts "Interest removed successfully..!"
    else
      @user.add_interest(@interest)
      puts "Interest added successfully..!"
    end
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [
          turbo_stream.replace("user_#{@user.id}_interest_#{@interest.id}", partial: 'users/interests', locals: { user: @user, interest: @interest }),
          turbo_stream.replace("interests-count", partial: 'users/next', locals: { count: current_user.interests.count })
        ]
      }
    end
  end

  private
  def set_interest
    @interest = Interest.find(params[:interest_id])
    @user = User.find(params[:user_id])
  end

  # check if the user is authenticated
  def authenticate_user
    if !current_user
      redirect_to new_user_sessions_path
    end
  end

end
