require 'spec_helper'



describe "User pages" do
  subject { page }
  describe "signup page" do
    before { visit new_user_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
  # Replace with code to make a user variable
  # 使用预构件生成user对象
  # let 方法指定的变量是“惰性”的，只有当后续有引用时才会被创建，let!则是立即创建
  let(:user) { FactoryGirl.create (:user) }
  before { visit user_path(user) }

  it { should have_content(user.name) }
  it { should have_title(user.name) }
  end

  # 测试注册功能（用填写表单提交表单的功能）
  describe "user sign_up" do

    before {  visit new_user_path }
    let(:submit) { "Create my account" }

    describe "invalid sign_up" do 
     it { expect { click_button submit }.not_to change(User, :count) }
    end

    # 这里要说下，测试用的应该是测试数据库，而email是有唯一限制的，那为什么连续运行两次都没错呢？
    # 估计是运行一次测试，运行完，测试数据库就会回滚一次(因为数据库一点东西都没有)
    describe "valid sign_up" do
      before do
        fill_in "Name", with: "Jackie"
        fill_in "Email", with: "Jackie@gmail.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should be success" do
        expect do
          click_button submit
        end.to change(User, :count).by(1)
      end
      
    end
    # 希望提交表单后，users表的个数增加多一个，change：会去调用User对象的,count方法.do 和 end 也可以用花括号来代替
  end
end




describe User do

  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                       password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

  describe "with valid password" do
    it { should eq found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end
end

describe "with a password that's too short" do
  before { @user.password = @user.password_confirmation = "a" * 5 }
  it { should be_invalid }
end

end