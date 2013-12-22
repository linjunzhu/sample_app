require 'spec_helper'

describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }
  .
  .
  .
  describe "remember token" do
    before { @user.save }
    # 用到了 its 方法，它和 it 很像，不过测试对象是参数中指定的属性而不是整个测试的对象
    its(:remember_token) { should_not be_blank }
  end
end