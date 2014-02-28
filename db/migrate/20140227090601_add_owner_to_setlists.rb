class AddOwnerToSetlists < ActiveRecord::Migration
  def change
    add_column :setlists, :owner, :string
  end
end
