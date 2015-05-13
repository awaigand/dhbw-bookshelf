module SearchHelper

  def query
    session[:book] = GoogleBooks.search("isbn: #{params[:isbn]}")
  end

end
