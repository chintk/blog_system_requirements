class StaticPagesController < ApplicationController
  def home
    if logged_in?
    	@comment = current_user.comments.build
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = all_feeds.paginate(page: params[:page])
    end
  end
end
