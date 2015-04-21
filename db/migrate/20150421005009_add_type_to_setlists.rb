class AddTypeToSetlists < ActiveRecord::Migration
  def change
    add_column :setlists, :type, :string
  end
end
