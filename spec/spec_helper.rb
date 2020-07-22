# frozen_string_literal: true

require 'bundler/setup'
require 'has_attached_tags'

require 'factory_bot'
require 'faker'

require_relative 'support/database'
require_relative 'support/image'

I18n.load_path += [File.expand_path('../lib/generators/has_attached_tags/templates/en.yml', __dir__)]

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    Database.prepare_test_database!
    FactoryBot.find_definitions
  end

  config.around(:each) do |example|
    Database.without_persisting_changes { example.run }
  end
end
