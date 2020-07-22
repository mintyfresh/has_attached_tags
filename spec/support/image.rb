# frozen_string_literal: true

class Image < ActiveRecord::Base
  extend HasAttachedTags

  has_one_tag :rating, required: true
  has_one_tag :source, type: 'website'

  has_many_tags :artists, required: true
  has_many_tags :characters
end
