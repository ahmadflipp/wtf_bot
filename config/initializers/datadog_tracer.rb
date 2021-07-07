# frozen_string_literal: true

# For instrumenting the app with datadog trace gem ddtrace
# The Rails integration will trace requests, database calls,
# templates rendering and cache read/write/delete operations.
# The integration makes use of the Active Support Instrumentation,
# listening to the Notification API so that any operation instrumented by the API is traced.

require 'ddtrace'
require 'flipp-rails-logger'

# APM configuration
Datadog.configure do |c|
  c.use :rails,
        service_name: 'wtf_bot'

  c.tracer(
    enabled: !defined?(Rails::Console) && %w(development test).exclude?(Rails.env),
    debug: %w(development).include?(Rails.env),
    hostname: ENV['HOST_IP'],
    env: Rails.env,
    tags: {
      service: 'wtf_bot'
    }
  )
end
