class AddUserIdToSetlists < ActiveRecord::Migration
  def change
    add_column :setlists, :user_id, :integer
  end
end
