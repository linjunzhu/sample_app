class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    # 因为我们设想要按照发布时间的倒序查询某个用户所有的微博，所以在上述代码中为 user_id 和 created_at 列加入了索引
    # 我们要创建的是“多键索引（multiple key index）”，Active Record 便会同时使用这两个键。
    add_index :microposts, [:user_id, :created_at]
  end
end
