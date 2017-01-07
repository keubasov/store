class CreateProductImages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_images do |t|
      t.belongs_to :look
    end
    add_foreign_key :product_images, :looks, on_delete: :cascade
  end
end
