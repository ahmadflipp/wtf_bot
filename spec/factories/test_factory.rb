# frozen_string_literal: true

# Example of a factory.
FactoryBot.define do
  factory(:widget) do
    test_id { 'a string goes here' }
  end
end
