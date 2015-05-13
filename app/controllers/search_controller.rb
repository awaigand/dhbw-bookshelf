class SearchController < ApplicationController

  def search
  end

  def query
    books = GoogleBooks.search("isbn:#{params[:isbn]}", {:count => 10})
    @books = books
  end



end
