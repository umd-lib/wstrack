# frozen_string_literal: true

require 'test_helper'

class WorkstationStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workstation_status = workstation_statuses(:epl_mac_ws)
  end

  test 'should get index' do
    get workstation_statuses_url
    assert_response :success
  end

  test 'should get new' do
    get new_workstation_status_url
    assert_response :success
  end

  test 'should create workstation_status' do
    assert_difference('WorkstationStatus.count') do
      post workstation_statuses_url,
           params: { workstation_status: { guest_flag: @workstation_status.guest_flag, os: @workstation_status.os,
                                           status: @workstation_status.status, user_hash: @workstation_status.user_hash,
                                           workstation_name: "#{@workstation_status.workstation_name}1" } }
    end

    assert_equal flash[:notice], 'Workstation status was successfully created.'
    assert_redirected_to workstation_status_url(WorkstationStatus.first)
  end

  test 'should show workstation_status' do
    get workstation_status_url(@workstation_status)
    assert_response :success
  end

  test 'should get edit' do
    get edit_workstation_status_url(@workstation_status)
    assert_response :success
  end

  test 'should update workstation_status' do
    patch workstation_status_url(@workstation_status),
          params: { workstation_status: { guest_flag: @workstation_status.guest_flag, os: @workstation_status.os,
                                          status: @workstation_status.status, user_hash: @workstation_status.user_hash,
                                          workstation_name: @workstation_status.workstation_name } }

    assert_equal flash[:notice], 'Workstation status was successfully updated.'
    assert_redirected_to workstation_status_url(@workstation_status)
  end

  test 'should destroy workstation_status' do
    assert_difference('WorkstationStatus.count', -1) do
      delete workstation_status_url(@workstation_status)
    end

    assert_equal flash[:notice], 'Workstation status was successfully destroyed.'
    assert_redirected_to workstation_statuses_url
  end

  test 'wstrack client endpoint should decode URL encoded "os" param' do
    # The "os" value from the wstrack-client will be URL encoded (i.e.,
    # spaces replaced with "+"). This test verifies that the unencoded
    # version (with spaces) is stored.
    os = 'Mac OS X 10.15.3'
    encoded_os = CGI.escape(os)

    get wstrack_client_url(
      guest_flag: @workstation_status.guest_flag,
      os: encoded_os,
      status: @workstation_status.status,
      user_hash: @workstation_status.user_hash,
      workstation_name: @workstation_status.workstation_name
    )

    status = WorkstationStatus.find_by(workstation_name: @workstation_status.workstation_name)
    assert_equal(os, status.os)
  end
end
