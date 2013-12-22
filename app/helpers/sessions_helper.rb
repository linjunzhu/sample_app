module SessionsHelper

  # 定义get set方法
  # attr_accessor :current_user

  def sign_in(user)
    remember_token = User.new_remember_token
    # 因为开发者经常要把 cookie 的失效日期设为 20 年后，所以 Rails 特别提供了 permanent 方法，
    # Rails 的 permanent 方法会自动把 cookie 的失效日期设为 20 年后。
    # cookies[:remember_token] = { value:   remember_token,
                             # expires: 20.years.from_now.utc }
    cookies.permanent[:remember_token] = remember_token
    # 保存记忆权标使用的是 update_attribute 方法，这样可以跳过数据验证更新单个属性。
    # 我们必须用这个方法，因为我们无法提供用户的密码及密码确认
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.encrypt(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)


  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    # 不过这样的做法，每次访问页面都会去DB查询，确实蛋疼，估计有其他的解决方法
    @current_user ||= User.find_by(remember_token: remember_token)
  end


end