require 'telleroo/connection'
require 'telleroo/request'
require 'telleroo/api'

module Telleroo
  # Client for the Telleroo API
  class Client
    include Telleroo::Connection
    include Telleroo::Request
    include Telleroo::API

    # Define the same set of accessors as the Telleroo module
    attr_accessor *Configuration::VALID_CONFIG_KEYS
    attr_accessor :last_response

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Telleroo::Client]
    def initialize(options = {})
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Telleroo.config.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
      yield(self) if block_given?
    end

    def last_response
      @last_response if defined? @last_response
    end
  end
end
