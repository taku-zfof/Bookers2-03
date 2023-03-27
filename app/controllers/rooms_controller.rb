class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room=Room.find(params[:id])

    @messages=@room.messages.all
    @message=Message.new

    @partner_bridges=@room.user_room_bridges
    @partner_bridge=@partner_bridges.where.not(user_id: current_user.id).first
    @user=User.find_by(id: @partner_bridge.user_id)
  end


  def create
   room=Room.new
   room.save
   current_bridge=UserRoomBridge.new(room_id: room.id, user_id: current_user.id)
   current_bridge.save

   partner_bridge=UserRoomBridge.new(room_id: room.id, user_id: params[:user_id])
   partner_bridge.save
   redirect_to room_path(room)
  end

  def index
  end

end


