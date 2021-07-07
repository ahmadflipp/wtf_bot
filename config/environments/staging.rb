# frozen_string_literal: true

require 'flipp-rails-logger'
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  config.logger = FlippRailsLogger.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
  # Use a different cache store in production.
  config.cache_store = :memory_store

end
