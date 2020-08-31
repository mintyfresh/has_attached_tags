# frozen_string_literal: true

module HasAttachedTags
  class Tagging < ActiveRecord::Base
    attr_readonly :tag_id, :attachment, :taggable_id, :taggable_type

    belongs_to :tag, class_name: 'HasAttachedTags::Tag', counter_cache: true, inverse_of: :taggings, optional: false
    belongs_to :taggable, inverse_of: false, optional: false, polymorphic: true

    validates :attachment, presence: true
    validates :tag, uniqueness: { scope: %i[attachment taggable], on: :create }

    # @param type [String]
    # @return [void]
    def self.[](type:)
      Class.new(self) do
        validate { errors.add(:tag, :unsupported, type: type) if tag && tag.type != type }
      end
    end
  end
end
