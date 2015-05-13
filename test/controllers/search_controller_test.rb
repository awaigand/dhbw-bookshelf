require 'test_helper'

class SearchControllerTest < ActionController::TestCase

  class FakeBook
    #BookMock
    attr_accessor :title, :authors, :image_link
    def initialize(title, authors, image_link)
      @title = title
      @authors = authors
      @image_link = image_link
    end
  end

  def setup

    @@book = FakeBook.new("An Imperial Afflication", "Peter Van Houten", "http://localhost")

    #Primitive GoogleBooks mocking, so it does work offline and is not dependend on Google being online
    def GoogleBooks.search *p
      if p.first == "test"
        return [@@book]
      end
      [] #requires something that can do "each"
    end
  end

  test "should get no error when search param is nil" do
    get :query
    assert_response :success
  end

  test "should get empty books message" do
    get :query
    assert_response :success
    assert_select '#empty', "No books found :("
  end

  test "should get single book result" do
    get :query, search:"test"
    assert_select '#empty', count:0
    assert_select '.bookrow' do
      assert_select "img[src=\"#{@@book.image_link}\"]"
      assert_select ".col-sm-9 > h1", "#{@@book.title} by #{@@book.authors}"
      assert_select "input[value=\"#{@@book.title}\"]"
      assert_select "input[value=\"#{@@book.image_link}\"]"
      assert_select "input[value=\"#{@@book.authors}\"]"
    end
    assert_response :success
  end

  test 'should recognize isbn-10 in search' do
    post :query, search: '3453146972'
    assert_response :ok
    assert_select '#flash', "You entered the ISBN of this book. Do you want to add it to your library?"
  end

  test 'should recognize isbn-13 in search' do
    post :query, search: '978-3453146972'
    assert_response :ok
    assert_select '#flash', "You entered the ISBN of this book. Do you want to add it to your library?"
  end

  test 'should recognize normal text in search' do
    post :query, search: 'Test Author'
    assert_response :ok
    assert_select '#flash', "Those are the results for the text you entered. Add?"
  end


end
