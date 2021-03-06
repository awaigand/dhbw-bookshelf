require 'test_helper'

class LendersControllerTest < ActionController::TestCase
  setup do
    @lender = lenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lenders)
  end

  test 'cant create invalid lender' do
    post :create, lender: {name: nil }
    assert_response :ok
    assert_select '#error_explanation ul' do
      assert_select 'li', "Name can&#39;t be blank"
    end
  end

  test "should be pretty index" do
    get :index
    for len in Lender.all
      assert_select ".row > .col-sm-6", len.name
      assert_select ".row > .col-sm-6", len.street+", "+len.city
    end
    assert_response :success
  end

  test "should show all lend books on lender page" do
    book = Book.create(:title => "Round ireland with a fridge", :image_link => "http://localhost", :lender_id => @lender.id)
    book2 = Book.create(:title => "The enormous room", :image_link => "http://localhost", :lender_id => @lender.id)
    book3 = Book.create(:title => "Einmal Rupert und zurück", :image_link => "http://localhost")
    get :show, id: @lender
    assert_select "a[href=\"#{book_path(book)}\"]"
    assert_select "a[href=\"#{book_path(book2)}\"]"
    assert_select "a[href=\"#{book_path(book3)}\"]", :count => 0
    assert_response :success
  end

  test "should be valid links to lender in index" do
    get :index
    for len in Lender.all
      assert_select ".row > .col-sm-6 > a[href=\"#{lender_path(len)}\"]"
    end
    assert_response :success
  end

  test 'cant update invalid lender' do
    patch :update, id: @lender, lender: { name: nil }
    assert_response :ok
    assert_select '#error_explanation ul' do
      assert_select 'li', "Name can&#39;t be blank"
    end
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lender" do
    assert_difference('Lender.count') do
      post :create, lender: { city: @lender.city, name: @lender.name, street: @lender.street }
    end

    assert_redirected_to lender_path(assigns(:lender))
  end

  test "should show lender" do
    get :show, id: @lender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lender
    assert_response :success
  end

  test "should update lender" do
    patch :update, id: @lender, lender: { city: @lender.city, name: @lender.name, street: @lender.street }
    assert_redirected_to lender_path(assigns(:lender))
  end

  test "should destroy lender" do
    assert_difference('Lender.count', -1) do
      delete :destroy, id: @lender
    end

    assert_redirected_to lenders_path
  end
end
