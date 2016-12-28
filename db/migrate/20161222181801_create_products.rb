class CreateProducts < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE product_types AS ENUM ('bedclothe', 'blanket', 'pillow', 'towel', 'matress');"
    execute "CREATE TYPE bedclothes_size AS ENUM ('one_half', 'two', 'two_euro', 'euro', 'family');"
    execute "CREATE TYPE bedclothes_material AS ENUM ('unbleached_calico', 'poplin', 'sateen');"

    create_table :products do |t|
      t.integer               :quantity,      null: false, default: 1
      t.money                 :price,         null: false
      t.string                :name,          null: false
      t.text                  :description
      t.string                :image
      t.timestamps
    end
    add_column :products,  :product_type, :product_types, null: false, default: :bedclothe, index: true
    # Bedclothes columns
    add_column :products,  :b_size,       :bedclothes_size
    add_column :products,  :b_material,   :bedclothes_material
  end

  def down
    drop_table(:products, if_exists: true)
    execute "DROP TYPE IF EXISTS product_types;"
    execute "DROP TYPE IF EXISTS bedclothes_size;"
    execute "DROP TYPE IF EXISTS bedclothes_material;"
  end
end
