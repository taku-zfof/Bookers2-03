class BookCommentsController < ApplicationController

  def create
    comment=BookComment.new(book_comment_params)
    comment.user_id=current_user.id

    book=Book.find(params[:book_id])
    comment.book_id=book.id
    comment.save
    @book=Book.find(params[:book_id])
    @book_comment=BookComment.new(book_comment_params)
  end

  def destroy
    comment=BookComment.find(params[:id])
    comment.destroy
    @book=Book.find(params[:book_id])
    @book_comment=BookComment.new
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
