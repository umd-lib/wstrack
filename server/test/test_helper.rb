# frozen_string_literal: true

require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::RcovFormatter
]
SimpleCov.start

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

# Suppress puma start/version output when running tests
Capybara.server = :puma, { Silent: true } # To clean up your test output

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
