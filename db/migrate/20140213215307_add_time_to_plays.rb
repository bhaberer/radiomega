class AddTimeToPlays < ActiveRecord::Migration
  def up
    add_column :plays, :time, :datetime
    Play.all { |play| play.update_attribute(:time, play.created_at) }
  end

  def down
    remove_column :plays, :time
  end
end
