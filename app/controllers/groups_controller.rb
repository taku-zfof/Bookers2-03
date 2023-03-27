class GroupsController < ApplicationController
  def index
    @groups=Group.all
    @book=Book.new
  end

  def show
    @group=Group.find(params[:id])
  end

  def create_form
    @group=Group.new
  end

  def create
    @group=Group.new(group_params)
    @group.owner_id = current_user.id
    @group.users << current_user
    if @group.save
     redirect_to groups_path
    else
     render "create_form"
    end
  end

  def destroy
    @group=Group.find(params[:id])
    @group.destroy
    redirect_to groups_path
  end


  def edit
    @group=Group.find(params[:id])
    unless @group.owner_id == current_user.id
     redirect_to groups_path
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :owner_id)
  end
end
