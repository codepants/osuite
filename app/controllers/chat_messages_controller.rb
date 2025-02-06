class ChatMessagesController < ApplicationController
  def index
    @messages = ChatMessage.includes(:user).order(created_at: :desc).limit(100)
  end

  def create
    @message = current_user.chat_messages.build(message_params)
    if @message.save
      # Broadcast handled by model
      head :ok
    else
      render json: { error: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:content)
  end
end 