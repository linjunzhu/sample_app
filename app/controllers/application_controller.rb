class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # 默认情况下，帮助函数只能在视图中使用，如果要在controller中使用的话就要手动include导入
  include SessionsHelper
end
