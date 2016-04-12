require 'test_helper'

# Test to verify the /track updates work correctly
class VerifyTrackingUpdateTest < ActionDispatch::IntegrationTest
  CONTENT_TYPE_JSON = 'application/json'.freeze
  def setup
    @new_wk_status = CurrentStatus.new(workstation_name: 'LIBRWKLMSPBF1J', status: 'login', os: 'Windows_NT',
                                       user_hash: 'LakJJ6PHPreRRBicGqHBxA', guest_flag: false)
    @exiting_wk_status = current_statuses(:current_status_sample)
  end

  test 'new tracking update should increment count' do
    assert_difference('CurrentStatus.count') do
      put "/track/#{@new_wk_status[:workstation_name]}/#{@new_wk_status[:status]}/#{@new_wk_status[:os]}"\
          "/#{@new_wk_status[:user_hash]}"
    end
  end

  test 'existing tracking update should not increment count' do
    assert_no_difference('CurrentStatus.count') do
      put "/track/#{@exiting_wk_status[:workstation_name]}/#{@exiting_wk_status[:status]}/#{@exiting_wk_status[:os]}"\
          "/#{@exiting_wk_status[:user_hash]}"
    end
  end

  test 'most recently updated status should be displayed first' do
    put "/track/#{@new_wk_status[:workstation_name]}/#{@new_wk_status[:status]}/#{@new_wk_status[:os]}"\
        "/#{@new_wk_status[:user_hash]}"
    assert_response :success
    get current_statuses_path, nil, Accept: CONTENT_TYPE_JSON
    assert response.content_type == CONTENT_TYPE_JSON,
           "Expected Content-Type: #{CONTENT_TYPE_JSON}, got: #{response.content_type}"
    statues = JSON.parse(@response.body)
    assert_equal statues[0]['workstation_name'], @new_wk_status[:workstation_name]
  end
end
