require 'spec_helper'

RSpec.describe Telleroo::Configuration do
  before do
    Telleroo.configure do |config|
      config.authorization_token = 'foo'
      config.endpoint = 'https://example.com/v1'
      config.http_adapter = :typhoeus
    end
  end

  describe '.authorization_token' do
    it 'should return default key' do
      expect(Telleroo.config.authorization_token).to eq('foo')
    end

    it 'is empty if not set' do
      authorization_token = Telleroo::Configuration.new.authorization_token
      expect(authorization_token).to be_nil
    end
  end

  describe '.endpoint' do
    it 'should return default endpoint' do
      expect(Telleroo.config.endpoint).to eq('https://example.com/v1')
    end

    it 'uses sandbox as default endpoint' do
      endpoint = Telleroo::Configuration.new.endpoint
      expect(endpoint).to eq('https://sandbox.telleroo.com')
    end
  end

  describe '.http_adapter' do
    it 'should return default http adapter' do
      expect(Telleroo.config.http_adapter).to eq(:typhoeus)
    end

    it 'uses Faraday.default_adapter as default http adapter' do
      endpoint = Telleroo::Configuration.new.http_adapter
      expect(endpoint).to eq(Faraday.default_adapter)
    end
  end

  describe '.options' do
    it 'returns a hash of configuration options' do
      expect(Telleroo.config.options).to be_an_instance_of(Hash)
    end
  end
end
