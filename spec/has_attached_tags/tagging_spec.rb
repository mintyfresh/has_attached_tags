# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasAttachedTags::Tagging do
  subject(:tagging) { build(:tagging) }

  it 'has a valid factory' do
    expect(tagging).to be_valid
  end

  it 'is invalid without a tag' do
    tagging.tag = nil
    expect(tagging).to be_invalid
  end

  it 'is invalid without a taggable object' do
    tagging.taggable = nil
    expect(tagging).to be_invalid
  end

  it 'is invalid without an attachment' do
    tagging.attachment = nil
    expect(tagging).to be_invalid
  end

  it 'is invalid when a duplicate tagging exists' do
    create(:tagging, tag: tagging.tag, taggable: tagging.taggable, attachment: tagging.attachment)
    expect(tagging).to be_invalid
  end

  it 'is valid when a similar tagging exists, but with a different attachment' do
    create(:tagging, tag: tagging.tag, taggable: tagging.taggable, attachment: 'something-else')
    expect(tagging).to be_valid
  end
end
