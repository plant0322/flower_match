class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :member_id, null: false
      t.integer :shop_id, null: false
      t.boolean :is_take_care, null: false, default: false

      t.timestamps
    end
  end
end
