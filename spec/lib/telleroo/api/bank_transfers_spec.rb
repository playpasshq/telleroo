require 'spec_helper'

RSpec.describe Telleroo::API::BankTransfers do
  include_context 'initialized client'

  let(:account_id) { '020a45e4-dfcf-49bf-be16-ba82a1b1e691' }
  let(:currency_code) { 'GBP' }
  let(:amount) { 600 }
  let(:recipient_id) { 'a6a2b79c-33b5-4ed5-90fd-bfb8f1d4085a' }
  let(:idempotent_key) { 'A87654321' }
  let(:status) { client.last_response.status }

  before do
    allow(client).to receive(:post).and_call_original
  end

  subject { client }

  describe '#create_transfer', vcr: { cassette_name: 'create_transfer' } do

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

    it 'calls post on /bank_transfers' do
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

  describe '#create_adhoc_transfer', vcr: { cassette_name: 'create_adhoc_transfer' } do

    let(:adhoc_params) do
      {
        account_id: account_id,
        currency_code: currency_code,
        amount: amount,
        recipient_name: 'Rick Floyd',
        account_no: 12345678,
        sort_code: 665544,
        idempotent_key: idempotent_key,
        reference: 'foo',
        tag: 'bar',
        reconciliation: 'baz'
      }
    end

    def do_post
      subject.create_adhoc_transfer(adhoc_params)
    end

    it 'calls post on /adhoc_bank_transfer' do
      expect(subject).to receive(:post).with('adhoc_bank_transfers', adhoc_params)
      do_post
    end

    it 'is successful' do
      do_post
      expect(status).to eq(200)
    end

    it 'returns the transaction' do
      response = do_post
      expect(response[:transaction][:id]).to be_present
    end
  end
end
