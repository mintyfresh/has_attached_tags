# frozen_string_literal: true

FactoryBot.define do
  factory :tagging, class: 'HasAttachedTags::Tagging' do
    association :tag, strategy: :build
    association :taggable, factory: :image, strategy: :build

    attachment { Faker::Lorem.word }
  end
end
