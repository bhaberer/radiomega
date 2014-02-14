class AddYoutubeLinkToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :youtube_id, :string
  end

  def down
    remove_column :songs, :youtube_link
  end
end
