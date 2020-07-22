# frozen_string_literal: true

FactoryBot.define do
  factory :tag, class: 'HasAttachedTags::Tag' do
    sequence(:name) { |n| "#{Faker::Lorem.word} #{n}" }
    type { Faker::Lorem.word }

    trait :artist do
      type { 'artist' }
    end

    trait :character do
      type { 'character' }
    end

    trait :rating do
      type { 'rating' }
    end

    trait :website do
      type { 'website' }
    end
  end
end
