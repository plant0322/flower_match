class CreateFavoriteShops < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_shops do |t|
      t.integer :member_id, null: false
      t.integer :shop_id, null: false

      t.timestamps
    end
  end
end
