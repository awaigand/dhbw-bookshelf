class SearchController < ApplicationController

  # From https://github.com/zapnap/isbn_validation/blob/master/lib/isbn_validation.rb
  ISBN10_REGEX = /^(?:\d[\ |-]?){9}[\d|X]$/i
  ISBN13_REGEX = /^(?:\d[\ |-]?){13}$/i

  def search
  end

  def query
      books_param = params[:search]
      flash[:message] = "Those are the results for the text you entered. Add?"
      if check_isbn(params[:search])
        flash[:message]= "You entered the ISBN of this book. Do you want to add it to your library?"
        books_param="isbn:#{params[:search]}"
      end
      @books = GoogleBooks.search(books_param, {:count => 10})
  end

private

  def check_isbn(isbn)
    # Note that this does not actually check if it is a VALID ISBN (checksum)
    # It only checks whether it is formatted like an ISBN
    if isbn
      isbn.match(ISBN10_REGEX) || isbn.match(ISBN13_REGEX)
    else
      false
    end

  end

end
