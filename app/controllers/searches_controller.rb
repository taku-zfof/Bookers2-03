class SearchesController < ApplicationController
  def search
    search_word=params[:word]
    @range=params[:range]
    @book=Book.new
     if @range=="Book"
       if params[:search]=="完全一致"
        @books = Book.where("title like? or body like?","#{search_word}","#{search_word}")
       elsif params[:search]=="前方一致"
        @books = Book.where("title like? or body like?","#{search_word}%","#{search_word}%")
       elsif params[:search]=="後方一致"
        @books = Book.where("title like? or body like?","%#{search_word}","%#{search_word}")
       else
        @books = Book.where("title like? or body like?","%#{search_word}%","%#{search_word}%")
       end
     else

       if params[:search]=="完全一致"
        @users = User.where("name like?","%#{search_word}%")
       elsif params[:search]=="前方一致"
        @users = User.where("name like?","%#{search_word}%")
       elsif params[:search]=="後方一致"
        @users = User.where("name like?","%#{search_word}%")
       else
        @users = User.where("name like?","%#{search_word}%")
       end
     end
  end
end