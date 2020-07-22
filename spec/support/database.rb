# frozen_string_literal: true

module Database
  class << self
    delegate :create_table, :drop_table, :disconnect!, to: 'ActiveRecord::Base.connection'

    def establish_connection
      ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
    end

    def without_persisting_changes
      ActiveRecord::Base.transaction do
        yield
        raise ActiveRecord::Rollback
      end
    end

    def prepare_test_database!
      establish_connection
      create_tags_table!
      create_taggings_table!
      create_images_table!
    end

  private

    def create_tags_table!
      Database.create_table(:tags, if_not_exists: true) do |t|
        t.string :name, null: false
        t.string :type, null: false
        t.integer :taggings_count, null: false, default: 0
        t.index %i[name type], unique: true
        t.timestamps
      end
    end

    def create_taggings_table!
      Database.create_table(:taggings, if_not_exists: true) do |t|
        t.belongs_to :tag, null: false, foreign_key: true
        t.belongs_to :taggable, null: false, polymorphic: true
        t.string :attachment, null: false
        t.index %i[tag_id attachment taggable_id taggable_type],
                name:   'index_taggings_on_unique_tag_attachment',
                unique: true
        t.timestamps
      end
    end

    def create_images_table!
      Database.create_table(:images, if_not_exists: true) do |t|
        t.string :url, null: false
        t.timestamps
      end
    end
  end
end
