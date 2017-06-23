require 'active_support/configurable'

module Telleroo
  # Configuration.
  #
  # Allows this:
  # Telleroo.configure do |config|
  #   config.authorization_token = 'deadbeef'
  #   config.endpoint = 'https://sandbox.telleroo.com'
  # end

  class Configuration
    include ActiveSupport::Configurable
    VALID_CONFIG_KEYS = [:authorization_token, :endpoint].freeze

    config_accessor :authorization_token

    config_accessor :endpoint do
      'https://sandbox.telleroo.com'
    end

    # Return the configuration values set in this module
    def options
      Hash[
        *Configuration::VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten
      ]
    end
  end
end
