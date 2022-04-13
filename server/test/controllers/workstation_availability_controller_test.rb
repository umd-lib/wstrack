# frozen_string_literal: true

require 'test_helper'

class WorkstationAvailabilityControllerTest < ActionDispatch::IntegrationTest
  setup do
    @art_location = locations(:art)
    @epl_location = locations(:epl)
    @epl_mac_ws = workstation_statuses(:epl_mac_ws)
    @art_pc_ws = workstation_statuses(:art_pc_ws)
    @epl_mac_ws.save
    @art_pc_ws.save
  end

  test 'should get index' do
    get availability_url
    assert_response :success
  end

  test 'should get list' do
    get availability_list_url
    assert_response :success
  end

  test 'should get list in JSON' do
    get availability_list_url, params: { format: :json }
    assert_response :success
    assert_match Mime[:json].to_str, response.content_type
    assert_equal file_fixture('avalability_list.json').read, response.body
  end

  test 'should get list in XML' do
    get availability_list_url, params: { format: :xml }
    assert_response :success
    assert_match Mime[:xml].to_str, response.content_type
    assert_equal file_fixture('avalability_list.xml').read, response.body
  end
end
