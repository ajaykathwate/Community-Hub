class InterestsController < ApplicationController

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
        render turbo_stream: turbo_stream.replace(dom_id(@user, :interests), partial: 'users/interests', locals:{user: @user, interest: @interest})
       }
    end
  end

  private
  def set_interest
    @interest = Interest.find(params[:interest_id])
    @user = User.find(params[:user_id])
  end

end
