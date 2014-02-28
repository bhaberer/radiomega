class AddLiveToSetlists < ActiveRecord::Migration
  def change
    add_column :setlists, :live, :boolean, default: false
  end
end
