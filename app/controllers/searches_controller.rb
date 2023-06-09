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
     elsif @range=="User"
       if params[:search]=="完全一致"
        @users = User.where("name like?","#{search_word}")
       elsif params[:search]=="前方一致"
        @users = User.where("name like?","#{search_word}%")
       elsif params[:search]=="後方一致"
        @users = User.where("name like?","%#{search_word}")
       else
        @users = User.where("name like?","%#{search_word}%")
       end
     elsif @range=="Tag"
       if params[:search]=="完全一致"
        @books = Book.where("Tag like?","#{search_word}")
       elsif params[:search]=="前方一致"
        @books = Book.where("Tag like?","#{search_word}%")
       elsif params[:search]=="後方一致"
        @books = Book.where("Tag like?","%#{search_word}")
       else
        @books = Book.where("Tag like?","%#{search_word}%")
       end
     end
  end

   def search_record
    user=User.find(params[:user_id])
    date= params[:date].to_date

    @count =user.books.where(created_at: date.all_day).count

   end
end