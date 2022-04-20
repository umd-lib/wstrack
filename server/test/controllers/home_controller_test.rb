# frozen_string_literal: true

require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'when not logged it, redirect to login page' do
    sign_out

    actions = [:index]

    actions.each do |action|
      get action
      assert_redirected_to '/login', "'#{action}' action did not redirect to expected page"
    end
  end

  test 'should display page when logged in' do
    sign_in

    get :index

    assert_response :success
    assert_template :index
  end
end
