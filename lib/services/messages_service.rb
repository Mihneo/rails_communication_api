class MessagesService
  attr_accessor :message_params

  def initialize(message_params)
    @message_params = message_params
  end

  def send_messages
    ActiveRecord::Base.transaction do
      message_params[:receiver_ids].uniq.each do |receiver_id|
        return unless User.exists?(id: receiver_id)

        @message = Message.new(body: message_params[:body], sender_id: message_params[:sender_id],
                               receiver_id: receiver_id)
        raise ActiveRecord::Rollback unless @message.save
      end
    end
    true
  end
end
