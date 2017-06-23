require 'faraday'
require 'telleroo/error'

module Telleroo
  module Response
    # Handles API Response Errors
    class RaiseClientError < Faraday::Response::Middleware
      def on_complete(env)
        status  = env[:status].to_i
        body    = env[:body]
        headers = env[:response_headers]

        case status
        when 401
          raise Telleroo::Error::Unauthorized.new body, headers
        when 406
          raise Telleroo::Error::NotAcceptable.new body, headers
        when 429
          raise Telleroo::Error::RateLimit.new body, headers
        end
      end
    end
  end
end
