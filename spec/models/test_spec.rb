# frozen_string_literal: true

RSpec.describe ApplicationRecord do
  it 'should create a test model' do
    ActiveRecord::Base.connection.create_table(:widgets, force: true) do |t|
      t.string(:test_id)
    end

    class Widget < ApplicationRecord # rubocop:disable RSpec/LeakyConstantDeclaration
    end

    model = FactoryBot.build(:widget)
    expect(model.test_id).to eq('a string goes here')
  end
end
