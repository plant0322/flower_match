class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :shop_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.string :size, null: false
      t.integer :stock, null: false
      t.integer :deadline, null: false
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
