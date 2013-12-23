# encoding utf-8
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # 如果有存储事先的地址则访问，否则访问user（用户点了需要登录的页面，则派上用场）
      redirect_back_or user

      # Sign the user in and redirect to the user's show page.
    else
      # flash和flash.now是不一样的，Flash 消息在一个请求的生命周期内是持续存在的。
      # 而render是重新渲染画面，不属于新的请求，因此flash还会存在这个错误消息
      # 而用了flash.now时，就算没有新的请求也会显示一次然后消失，适合render
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
      # Create an error message and re-render the signin form.
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
