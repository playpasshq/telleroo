require 'faraday'
require 'telleroo/response/raise_client_error'
require 'telleroo/response/raise_server_error'

module Telleroo
  # Setup Faraday Connection to use for requests
  module Connection
    private

    def connection
      @connection ||= Faraday.new(url: Telleroo.config.endpoint) do |faraday|
        faraday.use Telleroo::Response::RaiseClientError
        faraday.use Telleroo::Response::RaiseServerError
        faraday.headers['Authorization'] = Telleroo.config.authorization_token
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
