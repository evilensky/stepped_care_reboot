require 'test_helper'

class FeelControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
