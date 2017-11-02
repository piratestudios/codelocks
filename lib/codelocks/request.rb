module Codelocks
  class Request < Model
    class << self
      # Perform a request against the NetCode API
      #
      # @param [String] path the URI path to perform the request against
      # @param [Hash] params defined in Codelocks::NetCode
      #
      # @return [Codelocks::NetCode::Response]

      def create(path, params = {})
        response = client.connection.get(path, default_params.merge(params)) do |req|
          req.headers['x-api-key'] = client.api_key
        end

        Response.new(response)
      end

      private

      # The default params used in NetCode endpoint requests
      #
      # @return [Hash]

      def default_params
        {}
      end
    end
  end
end
