class ExploreController < ApplicationController

  def index
    # video_posts
    @video_posts = VideoPost.all

    # image messages
    @messages = Message.includes(:post_image_attachment).where.not(post_image_attachment: { id: nil })

    # combine both records
    @combined_records = @video_posts + @messages

    # shuffle records
    @shuffled_records = @combined_records.shuffle

    # all tags
    @tags = Tag.all.sort_by(&:name)

  end

end
