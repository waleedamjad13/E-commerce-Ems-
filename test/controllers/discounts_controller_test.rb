require 'test_helper'

class DiscountsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @discount = discounts(:one)
  end


  test "should create discount" do
    post admin_discounts_url, params: { discount: { name: 'test discount', value: 100 } }
    assert_redirected_to root_url
  end
end

