require 'spec_helper'

RSpec.describe Telleroo::API::Transactions do
  include_context 'initialized client'

  let(:id) { 123 }
  let(:account_id) { '7e583a6d-0869-4c62-9f2c-74a75b8c2a75' }
  let(:start_date) { '09-06-2017' }
  let(:end_date) { '09-07-2017' }

  subject { client }

  before do
    allow(client).to receive(:get).and_return true
  end

  describe '#get_transaction' do
    it 'calls get on /get_transaction/#{id}' do
      expect(subject).to receive(:get).with('transactions/123')
      subject.get_transaction(id)
    end
  end

  describe '#transactions' do
    it 'calls get on /transactions with params' do
      expect(subject).to receive(:get).with(
        'transactions',
        account_id: account_id,
        start_date: start_date,
        end_date: end_date,
        page: 1
      )
      subject.transactions(
        account_id: account_id,
        start_date: start_date,
        end_date: end_date
      )
    end
  end
end
