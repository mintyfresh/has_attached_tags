# frozen_string_literal: true

RSpec.shared_examples_for 'has_one_tag' do |attachment, type: attachment.to_s.singularize, required: false|
  if required
    it "is invalid without a #{attachment}" do
      subject.send("#{attachment}=", nil)
      expect(subject).to be_invalid
    end
  else
    it "is valid without a #{attachment}" do
      subject.send("#{attachment}=", nil)
      expect(subject).to be_valid
    end
  end

  it "is invalid when an unsupported tag is assigned to #{attachment}" do
    subject.send("#{attachment}=", create(:tag))
    expect(subject).to be_invalid
  end

  describe ".with_#{attachment}" do
    subject(:with_attachment) { described_class.send("with_#{attachment}", tag) }

    let!(:tag) { create(:tag, type: type) }
    let!(:image_with_tag) { create(:image, attachment => tag) }
    let!(:image_without_tag) { create(:image) }

    it 'includes images that have the tag' do
      expect(with_attachment).to include(image_with_tag)
    end

    it 'does not include images that do not have the tag' do
      expect(with_attachment).not_to include(image_without_tag)
    end
  end

  describe ".without_#{attachment}" do
    subject(:with_attachment) { described_class.send("without_#{attachment}", tag) }

    let!(:tag) { create(:tag, type: type) }
    let!(:image_with_tag) { create(:image, attachment => tag) }
    let!(:image_without_tag) { create(:image) }

    it 'does not includes images that have the tag' do
      expect(with_attachment).not_to include(image_with_tag)
    end

    it 'include images that do not have the tag' do
      expect(with_attachment).to include(image_without_tag)
    end
  end
end
