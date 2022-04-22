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
    config.time_zone = 'Eastern Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join("extras")

    # Configure the hostname, when HOST is provided.
    #
    # In Rails 6, middleware was added to prevent "DNS rebinding" attacks,
    # see https://guides.rubyonrails.org/v6.1/configuring.html#configuring-middleware
    # and https://github.com/rails/rails/pull/33145
    #
    # In the development environment, the middleware allows "localhost",
    # and the IPv4/IPv6 loopback addresses, and so does not normally need to
    # set. This application, however, uses SAML and Grouper, and therefore uses
    # a hostname other than "localhost", in order to identify itself to the
    # SAML IdP. The following sets the "config.hosts" if a "HOST" environment
    # variable is present, which is typically provided by the ".env" file.
    #
    # It is not strictly required, because other processes (such as running
    # the tests, or performing database migrations) do not require a HOST.
    # HOST should be ignored (and config.hosts not set) when running the tests.
    #
    # Note: As of Rails v6.1.4.4, regular expressions should not be wrapped in
    # '/A.../z', as it interferes with some regex manipulation Rails does
    # internally.
    if ENV['HOST'].present? && !Rails.env.test?
      config.hosts << /10\.\d+\.\d+\.\d+/
      config.hosts << ENV['HOST']
      config.action_mailer.default_url_options = { host: ENV['HOST'] }
    end

    config.x.history.storage_dir = ENV['HISTORY_STORAGE_DIR'] || Rails.root.join('tmp')
  end
end
