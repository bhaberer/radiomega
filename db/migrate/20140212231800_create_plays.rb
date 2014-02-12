class CreatePlays < ActiveRecord::Migration
  def change
    create_table :plays do |t|
      t.integer :song_id
      t.string :nick

      t.timestamps
    end
  end
end
