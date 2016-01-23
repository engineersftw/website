require 'rails_helper'

RSpec.describe Presenter, type: :model do
  describe 'associations' do
    it { should have_many(:video_presenters).dependent(:destroy) }
    it { should have_many(:episodes).through(:video_presenters) }
  end

  describe '#avatar' do
    context 'has Twitter' do
      subject{ build :presenter, :with_twitter }

      it 'displays avatar from Twitter' do
        expect(subject.avatar).to eq "https://avatars.io/twitter/#{subject.twitter}?size=large"
      end
    end

    context 'has email' do
      subject{ build :presenter, email: 'user@example.com' }

      it 'displays avatar from Gravatar' do
        expect(subject.avatar).to eq "https://gravatar.com/avatar/b58996c504c5638798eb6b511e6f49af?s=200&d=retro"
      end
    end

    context 'has avatar url' do
      subject{ build :presenter, :with_avatar_url }

      it 'displays avatar from Avatar URL' do
        expect(subject.avatar).to eq subject.avatar_url
      end
    end

    context 'when more than one field is set' do
      subject{ build :presenter, :with_avatar_url, :with_twitter }

      it 'avatar_url takes precedence' do
        expect(subject.avatar).to eq subject.avatar_url
      end
    end
  end
end
