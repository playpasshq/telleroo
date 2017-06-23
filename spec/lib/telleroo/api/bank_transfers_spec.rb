require 'spec_helper'

RSpec.describe Telleroo::API::BankTransfers do
  include_context 'initialized client'

  let(:account_id) { '020a45e4-dfcf-49bf-be16-ba82a1b1e691' }
  let(:currency_code) { 'GBP' }
  let(:amount) { 600 }
  let(:recipient_id) { 'a6a2b79c-33b5-4ed5-90fd-bfb8f1d4085a' }
  let(:idempotent_key) { 987_654_321 }
  let(:status) { client.last_response.status }

  before do
    allow(client).to receive(:post).and_call_original
  end

  describe '#create_transfer', vcr: { cassette_name: 'create_transfer' } do
    subject { client }

    def do_post
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

    it 'calls post with /bank_transfers' do
      expect(subject).to receive(:post).with(
        'bank_transfers',
        account_id: account_id,
        currency_code: currency_code,
        amount: amount,
        recipient_id: recipient_id,
        idempotent_key: idempotent_key,
        reference: 'foobar'
      )
      do_post
    end

    it 'is successful' do
      do_post
      expect(status).to eq(200)
    end

    it 'returns an hash' do
      response = do_post
      expect(response[:transaction]).to be_an_instance_of Hash
    end

    it 'returns the transaction' do
      response = do_post
      expect(response[:transaction][:id]).to be_present
    end
  end
end
