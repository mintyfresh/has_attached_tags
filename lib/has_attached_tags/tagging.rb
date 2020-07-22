# frozen_string_literal: true

module HasAttachedTags
  class Tagging < ActiveRecord::Base
    belongs_to :tag, class_name: 'HasAttachedTags::Tag', counter_cache: true, inverse_of: :taggings
    belongs_to :taggable, inverse_of: false, polymorphic: true

    validates :attachment, presence: true
    validates :tag, uniqueness: { scope: :taggable }
  end
end
