class CreateRelaionships < ActiveRecord::Migration
  def change
    create_table :relaionships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :rela
  end
end
