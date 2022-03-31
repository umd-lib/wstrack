# frozen_string_literal: true

require 'test_helper'

class WorkstationStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workstation_status = workstation_statuses(:one)
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
                                           workstation_name: @workstation_status.workstation_name,
                                           workstation_type: @workstation_status.workstation_type } }
    end

    assert_redirected_to workstation_status_url(WorkstationStatus.last)
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
                                          workstation_name: @workstation_status.workstation_name,
                                          workstation_type: @workstation_status.workstation_type } }
    assert_redirected_to workstation_status_url(@workstation_status)
  end

  test 'should destroy workstation_status' do
    assert_difference('WorkstationStatus.count', -1) do
      delete workstation_status_url(@workstation_status)
    end

    assert_redirected_to workstation_statuses_url
  end
end
