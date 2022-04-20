# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'when not logged it, redirect to login page' do
    get root_url
    assert_redirected_to login_url
  end

  test 'should display page when logged in' do
    login_with_valid_role

    get root_url
    assert_response :success
  end

  test 'should show "forbidden" page if login does not have correct role' do
    login_with_invalid_role
    assert_response :forbidden

    get root_url
    assert_redirected_to login_url
  end
end
