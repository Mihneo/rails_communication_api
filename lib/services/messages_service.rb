class MessagesService
  def self.send_messages(message_params)
    is_successful = true
    ActiveRecord::Base.transaction do
      message_params[:receiver_ids].uniq.each do |receiver_id|
        if User.exists?(id: receiver_id)
          @message = Message.new(body: message_params[:body], sender_id: message_params[:sender_id],
                                 receiver_id: receiver_id)

          unless @message.save
            is_successful = false
            raise ActiveRecord::Rollback
          end
        else
          is_successful = false
          raise ActiveRecord::Rollback
        end
      end
    end
    is_successful
  end
end
