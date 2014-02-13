class CreateSetlists < ActiveRecord::Migration
  def change
    create_table :setlists do |t|
      t.string :title
      t.timestamps
    end
  end
end
