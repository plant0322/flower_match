class AddInOrderToPickUpTags < ActiveRecord::Migration[6.1]
  def change
    add_column :pick_up_tags, :in_order, :integer, null: false, default: 0
  end
end
