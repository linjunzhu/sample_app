class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
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

  private

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
