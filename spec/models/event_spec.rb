require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:webuild_id) }
    it { should validate_presence_of(:group_id) }
    it { should validate_presence_of(:platform) }
  end
end
