# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HasAttachedTags::Tag do
  subject(:tag) { build(:tag) }

  it 'has a valid factory' do
    expect(tag).to be_valid
  end

  it 'is invalid without a name' do
    tag.name = nil
    expect(tag).to be_invalid
  end

  it 'is invalid without a type' do
    tag.type = nil
    expect(tag).to be_invalid
  end

  it 'is invalid when a duplicate tag exists' do
    create(:tag, name: tag.name, type: tag.type)
    expect(tag).to be_invalid
  end
end
