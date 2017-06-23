require 'spec_helper'

RSpec.describe Telleroo::API::Transactions do
  include_context 'initialized client'

  let(:id) { "9e99c5c6-7288-4141-bddd-e08c8bd42f13" }
  let(:account_id) { '020a45e4-dfcf-49bf-be16-ba82a1b1e691' }
  let(:start_date) { '09-06-2017' }
  let(:end_date) { '09-07-2017' }
  let(:status) { client.last_response.status }
  subject { client }

  before do
    allow(client).to receive(:get).and_call_original
  end

  describe '#get_transaction', vcr: { cassette_name: 'get_transaction' } do

    it 'is successful' do
      subject.get_transaction(id)
      expect(status).to eq(200)
    end

    it 'calls get on /get_transaction/#{id}' do
      expect(subject).to receive(:get).with("transactions/#{id}")
      subject.get_transaction(id)
    end
  end

  describe '#transactions', vcr: { cassette_name: 'transactions' } do
    def fetch_transactions
      subject.transactions(
        account_id: account_id,
        start_date: start_date,
        end_date: end_date
      )
    end

    it 'is successful' do
      fetch_transactions
      expect(status).to eq(200)
    end

    it 'calls get on /transactions with params' do
      expect(subject).to receive(:get).with(
        'transactions',
        account_id: account_id,
        start_date: start_date,
        end_date: end_date,
        page: 1
      )
      fetch_transactions
    end
  end
end
