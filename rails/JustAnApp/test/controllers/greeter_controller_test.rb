require 'test_helper'

class GreeterControllerTest < ActionController::TestCase
  test "should get heythere" do
    get :heythere
    assert_response :success
  end

end
