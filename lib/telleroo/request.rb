require 'multi_json'

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

    # @return [Hash]
    def request(method, path, params, _options)
      response = connection.run_request(method, nil, nil, nil) do |request|
        case method.to_sym
        when :get, :delete
          request.url(path, params)
        when :post
          request.path = path
          request.body = JSON.dump(params) unless params.empty?
        end
      end

      @last_response = response
      load_json(response.body) unless response.body.empty?
    end

    def load_json(response)
      MultiJson.load(response, symbolize_keys: true)
    end
  end
end
