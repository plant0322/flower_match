class ItemCheck < ApplicationRecord
  belongs_to :item

  enum permission: { permit: 0, confirm: 1, not_permit: 2 }
end
