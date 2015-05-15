class BooksController < ApplicationController

  def new
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(:title => params[:title], :image_link => params[:image_link])
    @book.authors << get_author_for_name(params[:author])
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @book = Book.find(params[:bookid])
      respond_to do |format|
      if @book.update({:lender_id => params[:lenderid]})
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_author_for_name (names)
    authors_coll = Array.new
    names = names.split(",")
    names.each do |name|
      author = Author.find_by_name(name)
      unless author
        author = Author.create(:name => name)
      end
    authors_coll.push(author)
    end
    return authors_coll
  end

end
