require 'test_helper'

class WorkstationAvailabilityControllerTest < ActionController::TestCase
  test 'should get availability' do
    get :index
    assert_response :success
  end
end
