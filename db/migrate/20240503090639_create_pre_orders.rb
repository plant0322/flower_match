class CreatePreOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :pre_orders do |t|
      t.integer :member_id, null: false
      t.integer :item_id, null: false
      t.string :name, null: false
      t.integer :total_payment, null: false
      t.integer :amount, null: false
      t.date :visit_day, null: false
      t.time :visit_time, null: false
      t.string :purpose, null: false
      t.text :note, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :last_name_kana, null: false
      t.string :first_name_kana, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :telephone_number, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
