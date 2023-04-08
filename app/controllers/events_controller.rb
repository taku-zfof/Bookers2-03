class EventsController < ApplicationController

  def new
    @group=Group.find(params[:group_id])
    @event=Event.new
  end

  def create
    @group=Group.find(params[:group_id])
    @event=Event.new(event_params)
    @event.group=@group
    @users=@group.users
    
   if @event.save
    EventMailer.event_email(@event,@users,current_user).deliver
    redirect_to group_event_done_path(@group,@event)
   else
    render "new"
   end
  end

  def done
    @event=Event.find(params[:event_id])
  end


private
 def event_params
    params.require(:event).permit(:title, :content)
 end
end
