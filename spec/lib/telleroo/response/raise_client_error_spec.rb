require 'spec_helper'

RSpec.describe Telleroo::Response::RaiseClientError do
  let(:env) do
    { status: '201' }
  end

  subject { described_class.new }

  context 'when status is 201' do
    it 'doesn\'t raise' do
      expect {
        subject.on_complete(env)
      }.to_not raise_error
    end
  end

  context 'when status is 401' do
    before do
      env[:status] = 401
    end

    it 'raises Unauthorized' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::Unauthorized)
    end
  end

  context 'when status is 406' do
    before do
      env[:status] = 406
    end

    it 'raises NotAcceptable' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::NotAcceptable)
    end
  end

  context 'when status is 422' do
    before do
      env[:status] = 422
    end

    it 'raises Unprocessable' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::Unprocessable)
    end
  end

  context 'when status is 429' do
    before do
      env[:status] = 429
    end

    it 'raises RateLimit' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::RateLimit)
    end
  end
end
