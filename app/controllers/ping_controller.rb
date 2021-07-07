# frozen_string_literal: true

# Controller that sends a simple OK message.
class PingController < ApplicationController

  def index
    build_commit = ENV['CONTAINER_BUILD_COMMIT'] || ''
    render status: :ok,
           json: {
             commit: build_commit
           }
  end

end
