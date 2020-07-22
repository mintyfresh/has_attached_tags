# frozen_string_literal: true

module HasAttachedTags
  class Tag < ActiveRecord::Base
    self.inheritance_column = nil

    has_many :taggings, class_name: 'HasAttachedTags::Tagging', dependent: :destroy, inverse_of: :tag

    validates :name, :type, presence: true

    scope :of_type, -> (type) { where(type: type) }
  end
end
