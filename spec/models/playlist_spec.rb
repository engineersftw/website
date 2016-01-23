require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'associations' do
    it { should have_many(:playlist_items) }
    it { should have_many(:episodes).through(:playlist_items) }
    it { should belong_to(:playlist_category) }
  end
end
