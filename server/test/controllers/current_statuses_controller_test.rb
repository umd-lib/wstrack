require 'test_helper'

class CurrentStatusesControllerTest < ActionController::TestCase
  setup do
    @current_status = current_statuses(:current_status_sample)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:current_statuses)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create current_status' do
    new_workstation_name = 'LIBRWKLMSPBF9J'
    assert_difference('CurrentStatus.count') do
      post :create, current_status: { guest_flag: @current_status.guest_flag, os: @current_status.os,
                                      status: @current_status.status, user_hash: @current_status.user_hash,
                                      workstation_name: new_workstation_name }
    end

    assert_redirected_to current_status_path(assigns(:current_status))
  end

  test 'should show current_status' do
    get :show, id: @current_status
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @current_status
    assert_response :success
  end

  test 'should update current_status' do
    patch :update, id: @current_status, current_status: { guest_flag: @current_status.guest_flag,
                                                          os: @current_status.os, status: @current_status.status,
                                                          user_hash: @current_status.user_hash,
                                                          workstation_name: @current_status.workstation_name }
    assert_redirected_to current_status_path(assigns(:current_status))
  end

  test 'should destroy current_status' do
    assert_difference('CurrentStatus.count', -1) do
      delete :destroy, id: @current_status
    end

    assert_redirected_to current_statuses_path
  end
end
