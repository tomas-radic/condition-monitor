require 'test_helper'

class PhasesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get phases_show_url
    assert_response :success
  end

end
