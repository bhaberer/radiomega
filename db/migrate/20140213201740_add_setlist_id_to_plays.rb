class AddSetlistIdToPlays < ActiveRecord::Migration
  def change
    add_column :plays, :setlist_id, :integer
  end
end
