require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "should not save book without a title" do
    book = Book.new
    assert_not book.save, "Saved the book without a title"
  end

  test "should only return books with given author in author scope" do
    book = Book.new(:title => "The Great Perhaps", :image_link => "http://localhost")
    Book.create(:title => "The Sequel", :image_link => "http://localhost")
    author = Author.create(:name => "John Blue")
    book.authors << author
    book.save

    assert_equal("The Great Perhaps",Book.for_author(author.name).first.title, "Returned wrong book or no book")
    assert_equal(1,Book.for_author(author.name).length, "Too many books")
  end

  test "should only return books with given lender in lender scope" do
    book = Book.new(:title => "The Life of Octavian Nothing", :image_link => "http://localhost", :lender_id => Lender.first.id)
    book.save
    assert_equal("The Life of Octavian Nothing",Book.for_lender(Lender.first).first.title, "Returned wrong book or no book")
    assert_equal(1,Book.for_lender(Lender.first).length, "Too many books")
  end


end
