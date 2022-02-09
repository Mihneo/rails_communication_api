class Message < ApplicationRecord
  validates_presence_of :body, :sender_id, :receiver_id

  scope :unseen, -> { where(seen: false) }

  def as_json(options = nil)
    { id: id, body: body, sender_id: sender_id, receiver_id: receiver_id,
      seen: seen, created_at: created_at.in_time_zone(User.find(receiver_id).time_zone) }
  end
end
