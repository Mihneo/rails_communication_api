class MessagesController < ApplicationController
  def index
    @messages = Message.where(receiver_id: current_user.id)
    @messages = @messages.unseen if params[:unseen] == 'true'
    @messages.map { |message| message.update(seen: true) }

    # json_string = MessageSerializer.new(@messages).serializable_hash.to_json
    render json: @messages, status: :ok
  end

  def create
    is_successful = MessagesService.send_messages(message_params)
    if is_successful
      render json: { "Status:": 'All messages sent successfully!' }, status: :created
    else
      render json: { "Status:": 'Messages have errors or user non existent.' }, status: :bad_request
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, receiver_ids: []).merge(sender_id: current_user.id)
  end
end
