class CreateProducts < ActiveRecord::Migration[5.0]
  def up
    execute "CREATE TYPE bedclothes_size AS ENUM ('one_half', 'two', 'two_euro', 'euro', 'family');"

    create_table :products do |t|
      t.integer               :quantity,      null: false, default: 1
      t.money                 :price,         null: false
      #t.string                :image
      t.timestamps
      t.belongs_to :look
    end
    # Bedclothes columns
    add_column :products,  :b_size,       :bedclothes_size
    add_foreign_key :products, :looks, on_delete: :cascade
  end

  def down
    drop_table(:products, if_exists: true)
    execute "DROP TYPE IF EXISTS bedclothes_size;"
  end
end
