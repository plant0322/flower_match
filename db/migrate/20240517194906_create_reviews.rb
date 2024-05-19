class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content, null: false
      t.integer :pre_order_id, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
