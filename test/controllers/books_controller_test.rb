require 'test_helper'

class BooksControllerTest < ActionController::TestCase

  setup do
    @book = Book.first
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should show search option if no books are present" do
    Book.delete_all
    get :index
    assert_select "#empty > h1", "No books yet."
    assert_select "#empty > h1 > a", "Search?"
    assert_response :success
  end

  test "should show books in a pretty fashion" do
    get :index
    for book in Book.all
      assert_select ".row > .col-sm-3 > img[src=\"#{book.image_link}\"]"
      assert_select ".row > .col-sm-9 > .row > .col-sm-12 > h1", book.title
    end
    assert_response :success
  end

  test "should have valid remove links in index" do
    get :index
    for book in Book.all
      assert_select ".row > .col-sm-9 > .row > .col-sm-12 > a[href=\"#{book_path(book)}\"]"
    end
    assert_response :success
  end

  test "should show lender if book is lend" do
    Book.create(:title => "Regarding the pain of others", :lender_id => Lender.first.id, :image_link => "http://localhost")
    get :index
    assert_select ".row > .col-sm-9 > .row > .col-sm-12 > p", "Lend to:" + Lender.first.name
    assert_response :success
  end

  test "should show valid lender link if book is lend" do
    Book.create(:title => "Regarding the pain of others", :lender_id => Lender.first.id, :image_link => "http://localhost")
    get :index
    assert_select ".row > .col-sm-9 > .row > .col-sm-12 > p > a[href=\"#{lender_path(Lender.first.id)}\"]"
    assert_response :success
  end

  test "should show unlend button if book is lend" do
    Book.create(:title => "Regarding the pain of others", :lender_id => Lender.first.id, :image_link => "http://localhost")
    get :index
    assert_select ".row > .col-sm-9 > .row > .col-sm-12 > form > input[value=\"#{Lender.first.name} returned the book\"]"
    assert_response :success
  end

  test "should show all lenders if not being lend" do
    get :index
    assert_select "select" do
      for len in Lender.all
        assert_select "option", len.name
      end
    end
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, title: @book.title, image_link: @book.image_link, author: "Author1, Author2, Author3"
    end
  end

  test 'cant create invalid book' do
    assert_no_difference('Book.count') do
      post :create, title: nil, image_link: @book.image_link, author: "Author1, Author2, Author3"
      assert_response :ok
    end
  end


  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, id: @book
    end

    assert_redirected_to books_path
  end

  test "should update book" do
    patch :update, id:@book, bookid: @book, lenderid: Lender.first.id
    assert_redirected_to book_path(@book)
  end

  test "should show title for each book" do
    Book.delete_all
    get :index, authors: nil
    assert_select "#empty > h1", "No books yet."
    assert_select "#empty > h1 > a", "Search?"
    assert_response :success
  end

  test "should show book" do
    get :show, id: @book
    assert_response :success
  end

end
