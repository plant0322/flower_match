class CreateItemDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :item_details do |t|
      t.integer :item_id, null: false
      t.integer :in_order, null: false, default: 0
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
