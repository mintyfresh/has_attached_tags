# frozen_string_literal: true

require 'rails/generators'

module HasAttachedTags
  class InstallGenerator < ::Rails::Generators::Base
    desc 'Creates the has_attached_tags configuration and locale files.'
    source_root File.expand_path('templates', __dir__)

    def install
      copy_file('en.yml', 'config/locales/has_attached_tags.en.yml')
    end
  end
end
