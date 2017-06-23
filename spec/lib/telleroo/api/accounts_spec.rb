require 'spec_helper'

RSpec.describe Telleroo::API::Accounts do
  include_context 'initialized client'
  let(:status) { client.last_response.status }

  before do
    allow(client).to receive(:get).and_call_original
  end

  describe '#accounts', vcr: { cassette_name: 'accounts' } do
    it 'calls get with /accounts' do
      expect(client).to receive(:get).with('accounts')
      client.accounts
    end

    it 'is successful' do
      client.accounts
      expect(status).to eq(200)
    end

    it 'returns an array' do
      response = client.accounts
      expect(response[:accounts]).to be_an_instance_of Array
    end

    it 'returns an array of accounts' do
      response = client.accounts
      expect(response[:accounts][0][:id]).to be_present
    end
  end
end
