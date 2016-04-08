require 'test_helper'

class CurrentStatusControllerTest < ActionController::TestCase
  test 'should get status' do
    get :statuses
    assert_response :success
    assert_select 'title', 'Current Status | Workstation Tracking'
  end
end
