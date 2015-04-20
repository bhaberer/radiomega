class CreateIrcnicks < ActiveRecord::Migration
  def change
    create_table :ircnicks do |t|
      t.text :nick
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
