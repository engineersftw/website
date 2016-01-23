require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_items).dependent(:destroy) }
    it { should have_many(:playlists).through(:playlist_items) }
    it { should have_many(:video_organizations).dependent(:destroy) }
    it { should have_many(:organizations).through(:video_organizations) }
    it { should have_many(:video_presenters).dependent(:destroy) }
    it { should have_many(:presenters).through(:video_presenters) }
    it { should have_many(:video_links).dependent(:destroy) }
  end
end
