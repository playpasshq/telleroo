require 'spec_helper'

RSpec.describe Telleroo::API::Recipients do
  include_context 'initialized client'

  let(:id) { 123 }
  subject { client }

  before do
    allow(described_class).to receive(:get).and_return true
    allow(described_class).to receive(:delete).and_return true
    allow(described_class).to receive(:post).and_return true
  end

  describe '#recipients' do
    it 'calls get on /recipients' do
      expect(subject).to receive(:get).with('recipients')
      subject.recipients
    end
  end

  describe '#get_recipient' do
    it 'calls get on /get_recipient/#{id}' do
      expect(subject).to receive(:get).with('recipients/123')
      subject.get_recipient(id)
    end
  end

  describe '#delete_recipient' do
    it 'calls delete on /delete_recipient/#{id}' do
      expect(subject).to receive(:delete).with('recipients/123')
      subject.delete_recipient(id)
    end
  end

  describe '#create_recipient' do
    it 'calls post on /recipients with params' do
      expect(subject).to receive(:post).with(
        'recipients',
        name: 'nick',
        currency_code: 'EUR',
        account_no: '123456',
        sort_code: 'ABCD'
      )
      subject.create_recipient(
        name: 'nick',
        currency_code: 'EUR',
        options: {
          account_no: '123456', sort_code: 'ABCD'
        }
      )
    end
  end
end
