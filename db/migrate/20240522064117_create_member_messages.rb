class CreateMemberMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :member_messages do |t|
      t.integer :member_id, null: false
      t.integer :room_id, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
