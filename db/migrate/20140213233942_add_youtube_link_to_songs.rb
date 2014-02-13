class AddYoutubeLinkToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :youtube_link, :string
  end
end
