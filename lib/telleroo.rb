require 'active_support/inflector'
require 'telleroo/version'
require 'telleroo/configuration'
require 'telleroo/client'

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'
end

module Telleroo
  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield config
  end

  # Return the config values set in this module
  def self.options
    Hash[
      * Configuration::VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten
    ]
  end
end
