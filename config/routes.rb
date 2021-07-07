# frozen_string_literal: true

Rails.application.routes.draw do

  get 'ping', to: 'ping#index'
  root 'ping#index'
end
