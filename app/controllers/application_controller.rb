# frozen_string_literal: true

# Base class for ActionControllers.
class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

end
