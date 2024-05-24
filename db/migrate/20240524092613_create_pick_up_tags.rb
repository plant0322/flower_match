class CreatePickUpTags < ActiveRecord::Migration[6.1]
  def change
    create_table :pick_up_tags do |t|
      t.integer :tag_id, null: false
      t.text :name, null: false
      t.string :introduction, null: false
      t.boolean :is_active, null: false, default: false

      t.timestamps
    end
  end
end
