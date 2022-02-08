class MessagesController < ApplicationController
  def create
    is_successful = MessagesHelper.send_messages(message_params.merge(sender_id: current_user.id))
    if is_successful
      render json: { "Status:": 'All messages sent successfully!' }, status: :created
    else
      render json: { "Status:": 'Messages have errors or user non existent.' }, status: :bad_request
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, receiver_ids: [])
  end
end
