class MemberMessage < ApplicationRecord
  belongs_to :member
  belongs_to :room

  validates :message, presence: true
end
