class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_comment=BookComment.new
    @book_view_count=BookViewCount.new(book_id: @book.id)
    @book_view_count.save
  end

  def index
    today  = Time.current.at_end_of_day
    sixdays_ago  = (today - 6.day).at_beginning_of_day
    @books = Book.all.sort_by{|x| x.favorites.where(created_at: sixdays_ago...today).size}.reverse
    @book=Book.new
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
    params.require(:book).permit(:title, :body, :score)
  end
end
