class CreateProducts < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE bedclothes_size AS ENUM ('one_half', 'two', 'two_euro', 'euro', 'family');"
    execute "CREATE TYPE bedclothes_material AS ENUM ('unbleached_calico', 'poplin', 'sateen');"

    create_table :products do |t|
      t.integer               :quantity,      null: false, default: 1
      t.money                 :price,         null: false
      #t.string                :image
      t.timestamps
      t.belongs_to :look, foreign_key: true
    end
    # Bedclothes columns
    add_column :products,  :b_size,       :bedclothes_size
    add_column :products,  :b_material,   :bedclothes_material
  end

  def down
    drop_table(:products, if_exists: true)
    execute "DROP TYPE IF EXISTS bedclothes_size;"
    execute "DROP TYPE IF EXISTS bedclothes_material;"
  end
end
