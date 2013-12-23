# encoing utf-8
class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    # will_paginate 的分页需要调用 paginate 方法：
    # :page 参数值由 params[:page] 指定，这个 params 元素是由 will_pagenate 自动生成的。
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]) 
    # 加入微博对象
    @microposts = @user.microposts.paginate(page: params[:page]) 
  end

  def create
    @user = User.new(create_user_params) 
    if @user.save
      # 设置已登录状态(放入cookie)
      sign_in @user
      # 给闪存flash添加信息
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # 既然事先过滤器已经先定义了@user,那就不用再写了
    # @user = User.find(params[:id])
  end

  def update
    # 既然事先过滤器已经先定义了@user,那就不用再写了
    # @user = User.find(params[:id])
    if @user.update_attributes(create_user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
