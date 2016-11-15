require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get logout" do
    get session_logout_url
    assert_response :success
  end

end
