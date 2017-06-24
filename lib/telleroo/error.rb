module Telleroo
  # Handle Errors returned from API
  class Error < StandardError
    attr_reader :http_headers

    def initialize(message, http_headers)
      @http_headers = http_headers
      super(message)
    end

    class ServerError < Telleroo::Error; end
    class ServiceUnavailable < Error::ServerError; end
    class ApplicationError < Error::ServerError; end

    class ClientError < Telleroo::Error; end
    class Unauthorized < Error::ClientError; end
    class NotAcceptable < Error::ClientError; end
    class Unprocessable < Error::ClientError; end
    class RateLimit < Error::ClientError; end
  end
end
