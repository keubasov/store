class CreateLooks < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE product_types AS ENUM ('bedclothe', 'blanket', 'pillow', 'towel', 'matress');"
    create_table :looks do |t|
      t.string :name
      t.text :description
    end
    add_column :looks,  :product_type, :product_types, null: false, default: :bedclothe, index: true
  end

  def down
    drop_table :looks, if_exist: true
    execute "DROP TYPE IF EXISTS product_types;"
  end
end
