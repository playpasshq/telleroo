require 'spec_helper'

RSpec.describe Telleroo::Request do
  describe 'methods included in module' do
    let(:class_with_inclusion) { Class.new.include(described_class) }
    subject { class_with_inclusion.new }
    before do
      allow(described_class).to receive(:request).and_return true
    end

    describe '#get' do
      it 'performs the request' do
        expect(subject).to receive(:request)
        subject.get('/accounts')
      end
    end

    describe '#post' do
      it 'performs the request' do
        expect(subject).to receive(:request)
        subject.post('/accounts')
      end
    end

    describe '#delete' do
      it 'performs the request' do
        expect(subject).to receive(:request)
        subject.delete('/accounts')
      end
    end
  end
end
