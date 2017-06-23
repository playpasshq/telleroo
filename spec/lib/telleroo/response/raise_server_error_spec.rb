require 'spec_helper'

RSpec.describe Telleroo::Response::RaiseServerError do
  let(:env) do
    { status: '503' }
  end

  subject { described_class.new }

  context 'when status is 503' do
    it 'raises ServiceUnavailable' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::ServiceUnavailable)
    end
  end

  context 'when status is 500' do
    before do
      env[:status] = 500
    end

    it 'raises ApplicationError' do
      expect {
        subject.on_complete(env)
      }.to raise_error(Telleroo::Error::ApplicationError)
    end
  end
end
