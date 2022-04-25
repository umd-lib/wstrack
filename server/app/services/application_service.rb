# frozen_string_literal: true

# Helper base class for calling "service" objects.
# See https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
class ApplicationService
  def self.perform(*args)
    new.perform(*args)
  end
end
