class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
    html = ApplicationController.render(
        partial: "messages/message",
        locals:{message: message}
      )
      ActionCable.server.broadcast("room_channel_#{message.chat_room_id}", {html: html} )
  end
end
