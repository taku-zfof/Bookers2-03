class MessagesController < ApplicationController

  def create
    if UserRoomBridge.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :body, :room_id).merge(user_id: current_user.id))
      redirect_to request.referrer
    else
      render "/rooms/show"
    end

  end

end
