require 'net/http'
require 'uri'

module Telleroo
  # Handles HTTP requests
  module Request
    def get(path, params = {}, options = {})
      request(:get, path, params, options)
    end

    def post(path, params = {}, options = {})
      request(:post, path, params, options)
    end

    def delete(path, params = {}, options = {})
      request(:delete, path, params, options)
    end

    private

    def request(method, path, params, _options)
      response = connection.run_request(method, nil, nil, nil) do |request|
        case method.to_sym
        when :get, :delete
          request.url(path, params)
        when :post
          request.path = path
          request.body = params unless params.empty?
        end
      end
      response.body
    end
  end
end
