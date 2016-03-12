require 'rails_helper'

RSpec.describe MailchimpService do
  let(:email) { 'me@example.com' }
  let(:full_name) { 'Steve Jobs' }
  let(:gibbon_double) { double }

  subject {
    MailchimpService.new(gibbon_double)
  }

  describe 'subscribe' do
    before do
      allow(gibbon_double).to receive_message_chain('lists.members.create').and_return(true)
    end

    it 'returns true' do
      expect(subject.subscribe(email, full_name)).to be
    end
  end
end

