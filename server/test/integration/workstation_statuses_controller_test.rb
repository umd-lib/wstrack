# frozen_string_literal: true

require 'test_helper'

class WorkstationStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_with_valid_role

    @workstation_status = workstation_statuses(:epl_mac_ws)
  end

  teardown do
    reset_login
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
    os = 'Test OS with spaces'
    encoded_os = CGI.escape(os)

    reset_login # endpoint is available without login

    get wstrack_client_url(
      guest_flag: 'f',
      os: encoded_os,
      status: 'login',
      user_hash: 'test_hash',
      workstation_name: 'TEST_WORKSTATION'
    )
    assert_response :success

    status = WorkstationStatus.find_by(workstation_name: 'TEST_WORKSTATION')
    assert_equal(os, status.os)
  end

  test 'wstrack client endpoint records valid entries to history' do
    Dir.mktmpdir do |temp_dir|
      Rails.configuration.x.history.storage_dir = temp_dir

      os = 'Mac OS X 10.15.3'
      encoded_os = CGI.escape(os)

      travel_to Time.parse('April 22, 2022 13:00:00 EDT') do
        get wstrack_client_url(
          guest_flag: 't',
          os: encoded_os,
          status: 'login',
          user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
          workstation_name: 'LIBRWKSTEMM3F383'
        )

        assert_response :success
      end

      expected_storage_path = Pathname.new(temp_dir).join('2022-04-22.csv')
      assert expected_storage_path.size?, 'No history entry was recorded.' # File exists and has non-zero size
    end
  end

  test 'wstrack client endpoint does not record invalid entries to history' do
    Dir.mktmpdir do |temp_dir|
      Rails.configuration.x.history.storage_dir = temp_dir

      travel_to Time.parse('April 22, 2022 13:00:00 EDT') do
        get wstrack_client_url(
          guest_flag: 't',
          os: 'Test OS',
          status: 'invalid_status',
          user_hash: 'y3Fu6SqTdoGUdaERmrF4SA==',
          workstation_name: 'LIBRWKSTEMM3F383'
        )

        assert_response :bad_request
      end

      expected_storage_path = Pathname.new(temp_dir).join('2022-04-22.csv')
      assert_not expected_storage_path.exist?, 'Invalid workstation status added to history'
    end
  end
end
