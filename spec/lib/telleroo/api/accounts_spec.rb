require 'spec_helper'

RSpec.describe Telleroo::API::Accounts do
  include_context 'initialized client'

  before do
    allow(client).to receive(:get).and_call_original
  end

  describe '#accounts', vcr: { cassette_name: 'accounts' } do
    it 'calls get with /accounts' do
      expect(client).to receive(:get).with('accounts')
      client.accounts
    end
  end
end
