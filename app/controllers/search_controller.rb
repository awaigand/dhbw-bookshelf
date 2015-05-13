class SearchController < ApplicationController

  def search
  end

  def query
    books = GoogleBooks.search("isbn: #{params[:isbn]}", {:count => 1})
    @book = books.first
  end



end
