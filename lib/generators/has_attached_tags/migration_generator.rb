# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/active_record'

module HasAttachedTags
  class MigrationGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration

    INPUT_FILE  = 'migration.rb.erb'
    OUTPUT_FILE = 'db/migrate/create_tags_and_taggings.rb'

    source_root File.expand_path('templates', __dir__)
    desc 'Creates the has_attached_tags migration file.'

    def install
      migration_template(INPUT_FILE, OUTPUT_FILE, migration_version: migration_version)
    end

    def self.next_migration_number(dirname)
      ActiveRecord::Generators::Base.next_migration_number(dirname)
    end

  private

    # @return [String, nil]
    def migration_version
      "[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]" if ActiveRecord::VERSION::MAJOR >= 5
    end
  end
end
