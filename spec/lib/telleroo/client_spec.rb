require 'spec_helper'

RSpec.describe Telleroo::Client do
  it 'uses the values passed in config if no args passed' do
    client = Telleroo::Client.new
    expect(client.endpoint).to eq(Telleroo.config.endpoint)
  end

  it 'merges options passed to override config' do
    client = Telleroo::Client.new(endpoint: 'telleroo')
    expect(client.endpoint).to eq('telleroo')
  end

  it 'ignores options that are not part of config' do
    expect { Telleroo::Client.new(show_me: 'the_money') }.to_not raise_error
  end
end
