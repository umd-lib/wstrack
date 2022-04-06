require "test_helper"

class WorkstationAvailabilityControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workstation_availability_index_url
    assert_response :success
  end
end
