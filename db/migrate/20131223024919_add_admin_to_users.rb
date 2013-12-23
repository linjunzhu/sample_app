class AddAdminToUsers < ActiveRecord::Migration
  def change
    # admin 属性的类型为布尔值，Active Record 会自动生成一个 admin? 方法
    add_column :users, :admin, :boolean, default: false
  end
end
