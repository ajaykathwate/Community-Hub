class VideoCallsController < ApplicationController

  def strat_video_call
    @video_call = VideoCall.new()
    @user = User.find(params[:started_by_user])
    @video_call.started_by_user = @user.id
    @video_call.user_id = @user.id
    @community = Community.find(params[:communiy_id])
    @video_call.community_id = @community.id
    @video_call.iframe_link = "https://tokbox.com/embed/embed/ot-embed.js?embedId=335393fa-37f8-48aa-aad7-e94c8103d455&room=#{@community.name}&iframe=true"
    puts "VideoCall: "
    puts @video_call
    # add this user to the video_call.users
    # craete a new participant and add it to the @video_call.paticipants
    # @participant = Participant.new(user_id: @user.id, video_call_id: @video_call.id)

    # unless @video_call.participants.include?(@participant)
    #   @video_call.participants << @participant
    #   @user.video_call = @video_call
    # end
    if @video_call.save!
      # send the notifications and then replace the turbo frame with he video_call data
        render turbo_stream: [
          turbo_stream.replace("video-call-tab", partial: 'layouts/video_call_tab', locals: { video_call: @video_call, community: @community, user: @user })
        ]
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end


  # join video call
  def join_video_call
    @video_call = VideoCall.find(params[:video_call_id])
    @community = Community.find(params[:community_id])
    @user = User.find(params[:user_id])
    # add this user to the video_call.users
    # craete a new participant and add it to the @video_call.paticipants
    # @participant = Participant.new(user_id: @user.id, video_call_id: @video_call.id)

    render turbo_stream: turbo_stream.replace("video-call-tab", partial: 'layouts/video_call_tab', locals: { video_call: @video_call, community: @community, user: @user })
      # turbo_stream.append("video-call-participant", partial: 'video_calls/participant', locals: { participant: @participant })


    # unless Participant.all.include?(@participant)
    #   @video_call.participants << @participant
    #   @user.video_call = @video_call
    # end
  end


  def end_video_call

    @video_call = VideoCall.find(params[:video_call_id])

    if @video_call.destroy!
      render turbo_stream: turbo_stream.replace("video-call-tab", partial: 'layouts/video_call_tab', locals: { video_call: @video_call, community: @community, user: @user })
    end

  end


end
