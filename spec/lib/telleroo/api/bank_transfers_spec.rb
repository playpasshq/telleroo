require 'spec_helper'

RSpec.describe Telleroo::API::BankTransfers do
  include_context 'initialized client'

  let(:account_id) { 123 }
  let(:currency_code) { 'EUR' }
  let(:amount) { 600 }
  let(:recipient_id) { 321 }
  let(:idempotent_key) { 123_456_789 }

  before do
    allow(client).to receive(:post).and_return true
  end

  describe '#create_transfer' do
    subject { client }

    it 'calls get with /bank_transfers' do
      expect(subject).to receive(:post).with(
        'bank_transfers',
        account_id: account_id,
        currency_code: currency_code,
        amount: amount,
        recipient_id: recipient_id,
        idempotent_key: idempotent_key,
        reference: 'foobar'
      )

      subject.create_transfer(
        account_id: account_id,
        currency_code: currency_code,
        amount: amount,
        recipient_id: recipient_id,
        idempotent_key: idempotent_key,
        options: {
          reference: 'foobar'
        }
      )
    end
  end
end
