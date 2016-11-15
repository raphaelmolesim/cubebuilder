require 'test_helper'

class CardControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get card_search_url
    assert_response :success
  end

end
