class NotificationsController < ApplicationController

  def create
    @notification = Notification.new(notification_patams)

    if @notification.save
      # Add the notification to current_user.notifications
      current_user.notifications << @notification
      puts "Notification saved to Database!"
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def notification_patams
    params.require(:notification).permit(:content, :user_id)
  end

end
