# frozen_string_literal: true

require 'active_record'

require 'has_attached_tags/version'
require 'has_attached_tags/tag'
require 'has_attached_tags/tagging'

module HasAttachedTags
  TAGGINGS_EXISTS = lambda { |tag, attachment, taggable|
    Tagging
      .where(tag: tag, attachment: attachment, taggable_type: taggable.polymorphic_name)
      .where(Tagging.arel_table[:taggable_id].eq(taggable.arel_table[:id]))
      .arel.exists
  }

  # @param attachment [Symbol]
  # @param type [String]
  # @param required [Boolean]
  # @return [void]
  def has_one_tag(attachment, type: default_type_for_attachment(attachment), required: false) # rubocop:disable Naming/PredicateName
    klass = define_attachment_tagging_class(attachment, type)

    has_one(:"#{attachment}_tagging", -> { where(attachment: attachment) },
            as: :taggable, autosave: true, class_name: klass.name, dependent: :destroy, inverse_of: :taggable)
    has_one(attachment, -> { of_type(type) }, source: :tag, through: :"#{attachment}_tagging")

    validates(attachment, presence: true) if required

    define_attachment_scopes(attachment)
  end

  # @param attachment [Symbol]
  # @param type [String]
  # @param required [Boolean]
  # @return [void]
  def has_many_tags(attachment, type: default_type_for_attachment(attachment), required: false) # rubocop:disable Naming/PredicateName
    klass = define_attachment_tagging_class(attachment, type)

    has_many(:"#{attachment}_taggings", -> { where(attachment: attachment) },
             as: :taggable, autosave: true, class_name: klass.name, dependent: :destroy, inverse_of: :taggable)
    has_many(attachment, -> { of_type(type) }, source: :tag, through: :"#{attachment}_taggings")

    validates(attachment, presence: true) if required

    define_attachment_scopes(attachment)
  end

private

  # @param attachment [Symbol]
  # @return [String]
  def default_type_for_attachment(attachent)
    attachent.to_s.singularize
  end

  # @param attachment [Symbol]
  # @param type [String]
  # @return [Class<Tagging>]
  def define_attachment_tagging_class(attachment, type)
    const_set("#{attachment}_tagging".camelize, Class.new(Tagging) do
      validate do
        errors.add(:tag, :unsupported, type: type) if tag && tag.type != type.to_s
      end
    end)
  end

  # @param attachment [Symbol]
  # @return [void]
  def define_attachment_scopes(attachment)
    # WHERE EXISTS (...) queries are used to prevent duplication of rows.
    scope(:"with_#{attachment}",    -> (tag) { where(TAGGINGS_EXISTS.call(tag, attachment, self))     })
    scope(:"without_#{attachment}", -> (tag) { where.not(TAGGINGS_EXISTS.call(tag, attachment, self)) })
  end
end
