class CreateProductImages < ActiveRecord::Migration[5.0]
  def change
    create_table :product_images do |t|
      t.belongs_to :look, foreign_key: true
    end
  end
end
