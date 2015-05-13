require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get search" do
    get :search
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
