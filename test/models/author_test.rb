require 'test_helper'

class AuthorTest < ActiveSupport::TestCase

  test "should not save author without name" do
    author = Author.new
    assert_not author.save, "Saved the author without a name"
  end

  test "should not save two authors with the same name" do
    Author.new(:name => "John Green").save
    author = Author.new(:name => "John Green")
    assert_not author.save, "Saved the author with the same name as another"
  end

end
