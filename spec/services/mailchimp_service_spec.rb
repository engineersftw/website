require 'rails_helper'

RSpec.describe MailchimpService do
  let(:email) { 'me@example.com' }
  let(:full_name) { 'Steve Jobs' }

  subject {
    MailchimpService.new
  }

  describe 'subscribe' do
    it 'returns true' do
      expect(subject.subscribe(email, full_name)).to be
    end

    xdescribe 'validation' do
      describe 'bad email' do
        let(:bad_email) { 'bad&&&&@example' }

        it 'returns false' do
          expect(subject.subscribe(bad_email, full_name)).not_to be
        end
      end
      describe 'no email' do
        let(:no_email) { '' }

        it 'returns false' do
          expect(subject.subscribe(no_email, full_name)).not_to be
        end
      end
      describe 'no first name' do
        let(:no_full_name) { '' }

        it 'returns false' do
          expect(subject.subscribe(email, no_full_name)).not_to be
        end
      end
    end
  end
end

