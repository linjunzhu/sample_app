# coding utf-8
class User < ActiveRecord::Base
  #  在保存之前把email全部转换成小写
  before_save { self.email = email.downcase }
  validates :name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }


# 我们要添加 password 和 password_confirmation 属性(虚拟属性），二者都要填写一些内容（非空格），而且要相等；
# 还要定义 authenticate 方法，对比加密后的密码和 password_digest 是否一致，验证用户的身份。
# 这些步骤本来很麻烦，不过在最新版的 Rails 中已经集成好了，只需调用一个方法就可以了，这个方法是 has_secure_password：
# 只要数据库中有 password_digest 列，在模型文件中加入 has_secure_password 方法后就能验证用户身份了。
# 因此是不需要在数据库中建立password,password_confirmation的，只需要password_digest就行了
# 测试数据库（在测试中如果要跟数据库打交道，就要建立测试数据库）
  has_secure_password
  validates :password, length: { minimum: 6 }

  before_create :create_remember_token

  # 3SecureRandom.urlsafe_base64 创建的字符串长度为 16，
  # 由 A-Z、a-z、0-9、下划线（_）和连字符（-）组成（每一位字符都有 64 种可能的情况，所以叫做“base64”）.

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
    # private或protected下额再缩进一下会好点
    def create_remember_token
      # 如果不指定 self 的话，我们就只是创建了一个名为 remember_token 的局部变量而已，这可不是我们期望得到的结果。
      # 加上 self 之后，赋值操作就会把值赋值给用户的 remember_token 属性，保存用户时，随着其他的属性一起存入数据库
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
