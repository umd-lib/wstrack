require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Wstrack
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure the hostname, when HOST is provided.
    # Note: A HOST environment variable (typically provided by a ".env" file)
    # is REQUIRED when running the application on a server.
    #
    # It is not strictly required, because that causes other processes that
    # don't require a HOST (such as performing the tests, or database
    # migrations) to fail.
    #
    # HOST should be ignored (and config.hosts not set) when running the tests.
    if ENV['HOST'].present? && !Rails.env.test?
      config.hosts << /\A10\.\d+\.\d+\.\d+\z/
      config.hosts << ENV['HOST']
      config.action_mailer.default_url_options = { host: ENV['HOST'] }
    end
  end
end
