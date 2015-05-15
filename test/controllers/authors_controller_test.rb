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
