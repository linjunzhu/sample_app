# encoding utf-8
class MicropostsController < ApplicationController
  before_action :signed_in_user
   before_action :correct_user,   only: :destroy

  def index
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      # 没有这个的话，在重新渲染页面时，在static controller中生成的@feed_items就会消失。这里前往要注意啊！！
      # 但是为什么那个@micropost没事呢？(因为这里前面生成了。。。)
      # 重新查找
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
