class RemovePriceFromLineItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :line_items, :price, :integer
  end
end
