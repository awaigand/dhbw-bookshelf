require 'test_helper'

class LenderTest < ActiveSupport::TestCase
  test "should not save lender without name" do
    lender = Lender.new
    assert_not lender.save, "Saved the lender without a name"
  end
end
