class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @books = Book.where(id: params[:id])
    @book_comment=BookComment.new
    book_view_count=BookViewCount.new(book_id: @book.id)
    book_view_count.save
    user= @book.user

    @current_bridges = UserRoomBridge.where(user_id: current_user.id)
    @partner_bridges = UserRoomBridge.where(user_id: user.id)

    unless user.id == current_user.id
      @current_bridges.each do|current_bridge|
       @partner_bridges.each do |partner_bridge|
        if current_bridge.room_id==partner_bridge.room_id
          @room_id = current_bridge.room_id
          @is_room = true
        end
       end
      end
     unless @is_room == true
       @room=Room.new
       @bridge=UserRoomBridge.new
     end
    end
  end

  def index
    today  = Time.current.at_end_of_day
    sixdays_ago  = (today - 6.day).at_beginning_of_day

    if params[:latest]
      @books = Book.latest
    elsif params[:score_count]
      @books = Book.score_count
    else
      @books = Book.all.sort_by{|x| x.favorites.where(created_at: sixdays_ago...today).size}.reverse
    end

    @book=Book.new
    user=current_user

    @current_bridges = UserRoomBridge.where(user_id: current_user.id)
    @partner_bridges = UserRoomBridge.where(user_id: user.id)

    unless user.id == current_user.id
      @current_bridges.each do|current_bridge|
       @partner_bridges.each do |partner_bridge|
        if current_bridge.room_id==partner_bridge.room_id
          @room_id = current_bridge.room_id
          @is_room = true
        end
       end
      end
     unless @is_room == true
       @room=Room.new
       @bridge=UserRoomBridge.new
     end
    end

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless@book.user==current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    uri = URI.parse("http://express.heartrails.com/api/json?method=getStations&x=#{@book.longitude}&y=#{@book.latitude}")
    response = Net::HTTP.get_response(uri)
    result = JSON.parse(response.body)
    
    @book.near_station = result['response']['station'][0]['name']
  
    
    # response = Net::HTTP.get_response(uri)
    # result = JSON.parse(response.body)
    # @book.near_station = result['response/station[0]["name"]']
    
    
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :score,:tag, :address, :latitude, :longitude, :near_station)
  end
end
