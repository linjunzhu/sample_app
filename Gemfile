# encoding utf-8
source 'http://ruby.taobao.org/'
ruby '2.0.0'

gem 'rails', '4.0.2'
gem 'bootstrap-sass', '2.3.2.0'
gem 'bcrypt-ruby', '~> 3.1.1'
# 能够生成注册许多用户的工具（现在知道的就只有获取大量不同的名字而已）
gem 'faker', '1.1.2'
# 分页工具
gem 'will_paginate', '3.0.4'
# 给分页弄上bootstrap样式
gem 'bootstrap-will_paginate', '0.0.9'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  # 测试框架
  gem 'rspec-rails', '2.13.1'
  gem 'pry', require: "pry"
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  # 可以不用开网页就能够进行测试 Capybara，这个 gem 允许我们使用类似英语中的句法编写模拟与应用程序交互的代码)
  gem 'capybara', '2.1.0'
  # 预构件 
  gem 'factory_girl_rails', '4.2.1'
end

gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '2.2.1'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'


group :doc do
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  gem 'pg', '0.15.1'
end
