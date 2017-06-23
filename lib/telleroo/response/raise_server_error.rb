require 'faraday'
require 'telleroo/error'

module Telleroo
  module Response
    # Handle Server Errors
    class RaiseServerError < Faraday::Response::Middleware
      def on_complete(env)
        status  = env[:status].to_i
        headers = env[:response_headers]

        case status
        when 500
          raise Telleroo::Error::ApplicationError.new "500 Something went wrong on our end. Please try again later.", headers
        when 503
          raise Telleroo::Error::ServiceUnavailable.new "503 No server is available to handle this request.", headers
        end
      end
    end
  end
end
