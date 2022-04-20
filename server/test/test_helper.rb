# frozen_string_literal: true

require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter
]
SimpleCov.start 'rails'

# Improved Minitest output (color and progress bar)
require 'minitest/reporters'

# add  Minitest::Reporters::SpecReporter.new to first param if you want to see
# what's running so slow.
Minitest::Reporters.use!(
  # Minitest::Reporters::SpecReporter.new,
  Minitest::Reporters::ProgressReporter.new,
  ENV,
  Minitest.backtrace_filter
)

# Suppress puma start/version output when running 'rails test:system test'
# Capybara.server = :puma, { Silent: true } # To clean up your test output

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  # Disabling parallelization, because it confuses SimpleCov
  # See https://github.com/simplecov-ruby/simplecov/issues/718
  # parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Authentication login for controller tests (ActionController::TestCase)
  def sign_in
    request.session = { authorized: true }
  end

  # Authentication logout for controller tests (ActionController::TestCase)
  def sign_out
    request.session.delete(:authorized)
  end

  # Valid login for integration tests (ActionDispatch::IntegrationTest)
  def login_with_valid_role
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:saml] = OmniAuth::AuthHash.new(
      {
        provider: 'saml',
        info: { roles: ['WorkstationTracking-Administrator'] }
      }
    )
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]

    post auth_callback_url(provider: 'saml')
  end

  # Login with invalid role for integration tests (ActionDispatch::IntegrationTest)
  def login_with_invalid_role
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:saml] = OmniAuth::AuthHash.new(
      {
        provider: 'saml',
        info: { roles: ['NotValidRole'] }
      }
    )
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:saml]

    post auth_callback_url(provider: 'saml')
  end

  # Clear any login credentials
  def reset_login
    OmniAuth.config.mock_auth[:saml] = nil
    Rails.application.env_config['omniauth.auth'] = nil
  end
end
