class CreateShopMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_messages do |t|
      t.integer :shop_id
      t.integer :room_id
      t.string :message

      t.timestamps
    end
  end
end
