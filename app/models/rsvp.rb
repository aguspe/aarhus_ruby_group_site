class Rsvp < ApplicationRecord
  belongs_to :member
  belongs_to :event

  enum :status, { yes: 0, maybe: 1, no: 2 }

  validates :member_id, uniqueness: { scope: :event_id }
end
