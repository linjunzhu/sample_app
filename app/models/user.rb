# coding utf-8
class User < ActiveRecord::Base

  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  # 我们可以使用 :source 参数告知 Rails followed_users 数组的来源是 followed 所代表的 id 集合。
  has_many :followed_users, through: :relationships, source: :followed

  # 粉丝的关联就建立在这层反转的关系上
  # 我们不会再建立一个完整的数据表来存放倒转后的关注关系。事实上，我们会通过被关注者和粉丝之间的对称关系来模拟一个 reverse_relationships 表，
  # 主键设为 followed_id。也就是说，relationships 表使用 follower_id 做外键：
  # 如果没有指定类名，Rails 会尝试寻找 ReverseRelationship 类，而这个类并不存在。
  # 这里还不是很明白，有空研究研究下-----------------------------------------------
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

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

  def feed
    # This is preliminary. See "Following users" for the full implementation.
     Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end


  private
    # private或protected下额再缩进一下会好点
    def create_remember_token
      # 如果不指定 self 的话，我们就只是创建了一个名为 remember_token 的局部变量而已，这可不是我们期望得到的结果。
      # 加上 self 之后，赋值操作就会把值赋值给用户的 remember_token 属性，保存用户时，随着其他的属性一起存入数据库
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
