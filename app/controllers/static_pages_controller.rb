class StaticPagesController < ApplicationController
  before_action :signed_in_user

  def home
    # 微博用
    @micropost = current_user.microposts.build if signed_in?
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def about
  end

  def help
  end

  def contact
  end
end
