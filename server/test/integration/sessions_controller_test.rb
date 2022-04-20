# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  teardown do
    reset_login
  end

  test 'when not logged it, redirect to login page' do
    reset_login
    get root_url
    assert_redirected_to login_url
  end

  test 'should display page when logged in' do
    login_with_valid_role

    get root_url
    assert_response :success
  end

  test 'should show "forbidden" page if login does not have correct role' do
    reset_login
    login_with_invalid_role
    assert_response :forbidden
    reset_login
    get root_url
    assert_redirected_to login_url
  end
end
