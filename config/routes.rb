# frozen_string_literal: true

Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :entries, only: [:index, :create, :show, :delete]
    end
  end
end
