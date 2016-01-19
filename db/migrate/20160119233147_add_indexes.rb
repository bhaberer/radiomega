class AddIndexes < ActiveRecord::Migration
  def change
    add_index :ircnicks, :user_id
    add_index :plays, :song_id
    add_index :plays, :setlist_id
    add_index :setlists, :user_id
  end
end
