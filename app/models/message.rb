class Message < ApplicationRecord
  validates_presence_of :body, :sender_id, :receiver_id

  scope :unseen, -> { where(seen: false) }
end
