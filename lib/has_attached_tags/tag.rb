# frozen_string_literal: true

module HasAttachedTags
  class Tag < ActiveRecord::Base
    self.inheritance_column = nil

    attr_readonly :type

    has_many :taggings, class_name: 'HasAttachedTags::Tagging', dependent: :destroy, inverse_of: :tag

    validates :name, :type, presence: true
    validates :name, uniqueness: { scope: :type, if: :name_changed? }

    scope :of_type, -> (type) { where(type: type) }
  end
end
