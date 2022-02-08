class MessagesController < ApplicationController
  def create
    if logged_in?
      is_successful = send_messages_transaction
      if is_successful
        render json: { "Status:": 'All messages sent successfully!' }, status: :created
      else
        render json: { "Status:": 'Messages have errors or user non existent.' }, status: :bad_request
      end
    else
      render json: {}, status: :unauthorized
    end
  end

  def send_messages_transaction
    is_successful = true
    ActiveRecord::Base.transaction do
      message_params[:receiver_ids].uniq.each do |receiver_id|
        @message = Message.new(body: message_params[:body], sender_id: current_user.id, receiver_id: receiver_id)

        unless @message.save && User.exists?(id: receiver_id)
          is_successful = false
          raise ActiveRecord::Rollback
        end
      end
    end
    is_successful
  end

  private

  def message_params
    params.require(:message).permit(:body, receiver_ids: [])
  end
end
