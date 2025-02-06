class ChatMessagesController < ApplicationController
  def index
    @messages = ChatMessage.includes(:user).order(created_at: :desc).limit(100)
  end

  def create
    @message = current_user.chat_messages.build(message_params)
    
    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to chat_messages_path }
        format.json { head :ok }
      else
        format.html { 
          flash[:alert] = @message.errors.full_messages.join(", ")
          redirect_to chat_messages_path
        }
        format.json { render json: { error: @message.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:chat_message).permit(:content)
  end
end 