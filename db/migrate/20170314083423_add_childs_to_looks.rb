class AddChildsToLooks < ActiveRecord::Migration[5.0]
  def change
    add_column :looks, :childs, :boolean
  end
end
