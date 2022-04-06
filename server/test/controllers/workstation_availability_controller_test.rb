require "test_helper"

class WorkstationAvailabilityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get availability_url
    assert_response :success
  end
end
