# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    url { Faker::Placeholdit.image }
    rating { build(:tag, :rating) }
    artists { build_list(:tag, artists_count, :artist) }

    transient do
      artists_count { 3 }
    end

    trait :with_source do
      source { build(:tag, :website) }
    end

    trait :with_characters do
      transient do
        characters_count { 3 }
      end

      characters { build_list(:tag, characters_count, :character) }
    end
  end
end
