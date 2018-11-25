require 'active_support/configurable'
require 'faraday'

module Telleroo
  # Configuration.
  #
  # Allows this:
  # Telleroo.configure do |config|
  #   config.authorization_token = 'deadbeef'
  #   config.endpoint = 'https://sandbox.telleroo.com'
  #   config.http_adapter = :typhoeus
  # end

  class Configuration
    include ActiveSupport::Configurable
    VALID_CONFIG_KEYS = [:authorization_token, :endpoint, :http_adapter].freeze

    config_accessor :authorization_token

    config_accessor :endpoint do
      'https://sandbox.telleroo.com'
    end

    config_accessor :http_adapter do
      Faraday.default_adapter
    end

    # Return the configuration values set in this module
    def options
      Hash[
        *Configuration::VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten
      ]
    end
  end
end
