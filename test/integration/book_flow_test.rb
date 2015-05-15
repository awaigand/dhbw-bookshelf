require 'test_helper'

class BookFlowTest < ActionDispatch::IntegrationTest
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

    @@book = FakeBook.new("An Imperial Affliction", "Peter Van Houten", "http://localhost")

    #Primitive GoogleBooks mocking, so it does work offline and is not dependend on Google being online
    def GoogleBooks.search *p
      result = []
      if p.first == "test"
        result << @@book
      end
      def result.total_items
        self.length
      end
      return result
    end
  end

   test "search and add a book" do
     get "/search/search"
     post_via_redirect "/search/query", :search => "test"
     assert_select ".bookrow", :count => 1
     assert_select ".bookrow > div > div > h1", "An Imperial Affliction by Peter Van Houten"
     post_via_redirect "/books", :title => @@book.title, :image_link => @@book.image_link, :author => @@book.authors
     assert_select '#notice', 'Book was successfully created.'
     assert_select 'h1', 'An Imperial Affliction'
   end

  test "add a lender to a book" do
    get "/books"
    for len in Lender.all
      assert_select "select > option", len.name
    end
    patch_via_redirect book_path(Book.first), :id => Book.first.id, :bookid => Book.first.id, :lenderid => Lender.first.id
    assert_response :ok
    assert_equal(Book.first.lender_id, Lender.first.id)
  end

end
