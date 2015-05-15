require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @author = authors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, author: { name: "New name" }
    end

    assert_redirected_to author_path(assigns(:author))
  end

  test "should show author" do
    get :show, id: @author
    assert_response :success
  end

  test "should show author's books on his page" do
    Book.first.authors << @author
    get :show, id: @author
    assert_select ".row > .col-sm-3 > img[src=\"#{Book.first.image_link}\"]"
    assert_select ".row > .col-sm-9 > .row > .col-sm-12 > h1", Book.first.title
    assert_response :success
  end

  test "should show authors books on index page" do
    Book.first.authors << @author
    Book.last.authors << Author.last
    get :index
    for author in Author.all
      for book in author.books
        assert_select "li > a[href=\"#{book_path(book)}\"]"
      end
    end
    assert_response :success
  end

  test "should show valid links to author on index page" do
    get :index
    for author in Author.all
      assert_select ".row > .col-sm-6 > a[href=\"#{author_path(author)}\"]"
    end
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @author
    assert_response :success
  end

  test "should update author" do
    patch :update, id: @author, author: { name: "New name" }
    assert_redirected_to author_path(assigns(:author))
  end

  test 'cant create invalid author' do
    post :create, author: {name: nil }
    assert_response :ok
    assert_select '#error_explanation ul' do
      assert_select 'li', "Name can&#39;t be blank"
    end
  end

  test 'cant update invalid author' do
    patch :update, id: @author, author: { name: nil }
    assert_response :ok
    assert_select '#error_explanation ul' do
      assert_select 'li', "Name can&#39;t be blank"
    end
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, id: @author
    end

    assert_redirected_to authors_path
  end
end
