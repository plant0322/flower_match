class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :member_id
      t.integer :shop_id
      t.boolean :is_take_care, null: false, default: false

      t.timestamps
    end
  end
end
