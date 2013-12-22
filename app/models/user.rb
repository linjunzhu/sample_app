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
end
