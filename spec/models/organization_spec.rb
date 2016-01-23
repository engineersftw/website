require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'associations' do
    it { should have_many(:video_organizations).dependent(:destroy) }
    it { should have_many(:episodes).through(:video_organizations) }
  end
end
