require 'spec_helper'

RSpec.describe Telleroo::API::Recipients do
  include_context 'initialized client'

  let(:id) { "95a3fd24-a96b-46d6-922e-c235fd1749cc" }
  let(:status) { client.last_response.status }
  subject { client }

  before do
    allow(client).to receive(:get).and_call_original
    allow(client).to receive(:delete).and_call_original
    allow(client).to receive(:post).and_call_original
  end

  describe '#recipients', vcr: { cassette_name: 'recipients' } do
    it 'is successful' do
      subject.recipients
      expect(status).to eq(200)
    end

    it 'returns an array' do
      response = subject.recipients
      expect(response[:recipients]).to be_an_instance_of Array
    end

    it 'returns an array of recipient objects' do
      response = subject.recipients
      expect(response[:recipients][0][:id]).to be_present
    end

    it 'calls get on /recipients' do
      expect(subject).to receive(:get).with('recipients')
      subject.recipients
    end
  end

  describe '#get_recipient', vcr: { cassette_name: 'get_recipient' } do
    it 'is successful' do
      subject.get_recipient(id)
      expect(status).to eq(200)
    end

    it 'returns an hash' do
      response = subject.get_recipient(id)
      expect(response[:recipient]).to be_an_instance_of Hash
    end

    it 'calls get on /get_recipient/#{id}' do
      expect(subject).to receive(:get).with("recipients/#{id}")
      subject.get_recipient(id)
    end
  end

  describe '#delete_recipient', vcr: { cassette_name: 'delete_recipient' } do
    it 'is successful' do
      subject.delete_recipient(id)
      expect(status).to eq(204)
    end

    it 'calls delete on /delete_recipient/#{id}' do
      expect(subject).to receive(:delete).with("recipients/#{id}")
      subject.delete_recipient(id)
    end
  end

  describe '#create_recipient' do
    context 'when account is GBP', vcr: { cassette_name: 'create_recipient_gbp' } do
      def do_post
        subject.create_recipient(
          name: 'Nick Lloyd',
          currency_code: 'GBP',
          options: {
            account_no: '72345678',
            sort_code: '623456'
          }
        )
      end

      it 'is successful' do
        do_post
        expect(client.last_response.status).to eq(200)
      end

      it 'returns the recipient' do
        response = do_post
        expect(response[:recipient][:id]).to be_present
      end

      it 'calls post on /recipients with params' do
        expect(subject).to receive(:post).with(
          'recipients',
          name: 'Nick Lloyd',
          currency_code: 'GBP',
          account_no: '72345678',
          sort_code: '623456'
        )
        do_post
      end
    end

    context 'when account is EUR', vcr: { cassette_name: 'create_recipient_eur' } do
      def do_post
        subject.create_recipient(
          name: 'Rick Floyd',
          currency_code: 'EUR',
          options: {
            iban: 'GB04BARC20474473160944',
            bic: 'BARCGB22'
          }
        )
      end

      it 'is successful' do
        do_post
        expect(client.last_response.status).to eq(200)
      end

      it 'returns the recipient' do
        response = do_post
        expect(response[:recipient][:id]).to be_present
      end
    end
  end
end
