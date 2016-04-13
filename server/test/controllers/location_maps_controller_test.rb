require 'test_helper'

class LocationMapsControllerTest < ActionController::TestCase
  setup do
    @location_map = location_maps(:one)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:location_maps)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create location_map' do
    unique_regex = '/(?i)^LIBRWKMCK[PM]2F.*$/'
    assert_difference('LocationMap.count') do
      post :create, location_map: { code: @location_map.code, regex: unique_regex, value: @location_map.value }
    end

    assert_redirected_to location_map_path(assigns(:location_map))
  end

  test 'should show location_map' do
    get :show, id: @location_map
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @location_map
    assert_response :success
  end

  test 'should update location_map' do
    patch :update, id: @location_map, location_map: { code: @location_map.code, regex: @location_map.regex,
                                                      value: @location_map.value }
    assert_redirected_to location_map_path(assigns(:location_map))
  end

  test 'should destroy location_map' do
    assert_difference('LocationMap.count', -1) do
      delete :destroy, id: @location_map
    end

    assert_redirected_to location_maps_path
  end
end
