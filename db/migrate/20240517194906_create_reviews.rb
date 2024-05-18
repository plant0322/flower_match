class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content, null: false
      t.integer :pre_order_id, null: false

      t.timestamps
    end
  end
end
