# frozen_string_literal: true

module ActionDispatch
  # Change the exception logging so it does one line with newlines
  # instead of a separate JSON log per line.
  class DebugExceptions

    # @param request [ActionDispatch::Request]
    # @param wrapper [ExceptionWrapper]
    def log_error(request, wrapper)
      logger = logger(request)
      return unless logger

      exception = wrapper.exception

      trace = wrapper.application_trace
      trace = wrapper.framework_trace if trace.empty?

      ActiveSupport::Deprecation.silence do
        code = exception.try(:annoted_source_code) || []
        exception_message = "#{exception.class} (#{exception.message})"
        logger.fatal("#{exception_message}: #{code.join("\n")} #{trace.join("\n")}")
      end
    end

  end
end
