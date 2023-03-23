class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]


  def create(user_params)
    @user=User.new
    @user.save
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @current_bridges = UserRoomBridge.where(user_id: current_user.id)
    @partner_bridges = UserRoomBridge.where(user_id: @user.id)
    unless @user.id == current_user.id

      @current_bridges.each do|current_bridge|
      @partner_bridges.each do |partner_bridge|
        if current_bridge.room_id==partner_bridge.room_id
          @room_id=current_bridge.room_id
          @is_room=true
        end
     end
     end
     unless@is_room
       @room=Room.new
       @bridge=UserRoomBridge.new
     end
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user=User.find(params[:id])
    unless @user==current_user
      redirect_to user_path(current_user)
    end

  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end


  def followings
    @user=User.find(params[:id])
    @users=@user.followings
    @book = Book.new
  end

  def followers
    @user=User.find(params[:id])
    @users=@user.followers
    @book=Book.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
