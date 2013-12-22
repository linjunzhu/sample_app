class DeleteColumnsToUers < ActiveRecord::Migration
  def change
    remove_column :users, :password
    remove_column :users, :password_confirmation
    remove_column :users, :testa
  end
end
