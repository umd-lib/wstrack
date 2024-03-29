# frozen_string_literal: true

require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_with_valid_role

    @location = locations(:art)
  end

  teardown do
    reset_login
  end

  test 'should get index' do
    get locations_url
    assert_response :success
  end

  test 'should get new' do
    get new_location_url
    assert_response :success
  end

  test 'should create location' do
    location_regex = "#{@location.regex}1"
    assert_difference('Location.count') do
      post locations_url,
           params: { location: { code: @location.code, regex: location_regex, name: @location.name } }
    end

    assert_equal flash[:notice], 'Location was successfully created.'
    assert_redirected_to location_url(Location.find_by(regex: location_regex))
  end

  test 'should show location' do
    get location_url(@location)
    assert_response :success
  end

  test 'should get edit' do
    get edit_location_url(@location)
    assert_response :success
  end

  test 'should update location' do
    patch location_url(@location),
          params: { location: { code: @location.code, regex: @location.regex, name: @location.name } }

    assert_equal flash[:notice], 'Location was successfully updated.'
    assert_redirected_to location_url(@location)
  end

  test 'should destroy location' do
    assert_difference('Location.count', -1) do
      delete location_url(@location)
    end

    assert_equal flash[:notice], 'Location was successfully destroyed.'
    assert_redirected_to locations_url
  end

  test 'should not destroy location with associated workstation status' do
    workstation_status = WorkstationStatus.new(
      {
        workstation_name: 'LIBRWKARTM1F_TEST', os: 'test', user_hash: 'test',
        status: 'login', guest_flag: false
      }
    )
    workstation_status.save!
    assert @location.workstation_status.any?

    assert_no_difference('Location.count') do
      delete location_url(@location)
    end

    assert_equal flash[:error],
                 "Location '#{@location.code}' cannot be destroyed because it has associated workstation statuses."
    assert_redirected_to locations_url
  end
end
