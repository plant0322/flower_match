class CreateMemberMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :member_messages do |t|
      t.integer :member_id
      t.integer :room_id
      t.string :message

      t.timestamps
    end
  end
end
