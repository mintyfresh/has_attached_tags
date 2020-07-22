# frozen_string_literal: true

require 'spec_helper'
require 'support/has_one_tag'
require 'support/has_many_tags'

RSpec.describe Image do
  subject(:image) { build(:image) }

  it 'has a valid factory' do
    expect(image).to be_valid
  end

  it_behaves_like 'has_one_tag', :rating, required: true
  it_behaves_like 'has_one_tag', :source, type: 'website'

  it_behaves_like 'has_many_tags', :artists, required: true
  it_behaves_like 'has_many_tags', :characters
end
