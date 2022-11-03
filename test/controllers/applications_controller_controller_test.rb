require 'test_helper'

class ApplicationsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get applications_controller_index_url
    assert_response :success
  end

end
