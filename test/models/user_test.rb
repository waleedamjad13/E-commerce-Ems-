require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "test cases of user" do 
    user = users(:one)
    assert_no_match "jonas", user.lastname, "Last name should not be amjad"
  end
end