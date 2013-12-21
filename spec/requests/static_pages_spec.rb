# coding utf-8
require 'spec_helper'

describe "Static pages" do

  # 指明要测试的对象就是page
  subject { page }

  describe "Home page" do
    # 访问这个网页（避免下面每次都要写重复)
    before { visit root_path }

    # it "should have the content 'Sample App'" do
    #   expect(page).to have_content('Sample App')
    # end
    # 这写法跟上面的一样（不过expect(page)就不用了）
    it { should have_content('Sample App') }
    it { should have_title(full_title('Home')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end
