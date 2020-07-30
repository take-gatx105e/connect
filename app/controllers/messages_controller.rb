class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      flash.now[:danger] = 'メッセージの送信に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end
end
