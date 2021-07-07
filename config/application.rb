# frozen_string_literal: true

require_relative 'boot'

require 'action_controller/railtie'
require 'active_record/railtie'
require 'active_job/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# :nodoc:
module WtfBot
  # :nodoc:
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.time_zone = 'Eastern Time (US & Canada)'
    config.middleware.use ActionDispatch::Flash

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

  end
end
