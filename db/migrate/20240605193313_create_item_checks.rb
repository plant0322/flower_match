class CreateItemChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :item_checks do |t|
      t.integer :item_id, null: false
      t.boolean :label_check, null: false
      t.integer :permission, null: false

      t.timestamps
    end
  end
end
