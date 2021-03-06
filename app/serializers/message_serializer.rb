class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :sender_id, :receiver_id, :seen, :received_at

  def received_at
    object.created_at.in_time_zone(current_user.timezone)
  end
end
