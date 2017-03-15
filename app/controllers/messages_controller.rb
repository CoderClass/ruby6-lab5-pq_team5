class MessagesController < ApplicationController
	def index
		@messages = Message.all.order(created_at: :desc)
	end

  def create
    @message = Message.new message_params
    if @message.save 
      flash[:sucess] = "Create message"  
      ActionCable.server.broadcast("chat", data:render_message(@message))                  
    else
      flash[:error] = "Error #{@message.errors.full_messages.to_sentence}"
      
    end
    redirect_to messages_path
  end

  def render_message(message)
    ApplicationController.render(partial: 'messages/message', locals: {message: message})
  end
  private
  def message_params
    params.require(:message).permit(:body)
  end
end
