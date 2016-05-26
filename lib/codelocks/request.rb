module Codelocks
  class Request
    class << self
      # Perform a request against the NetCode API
      #
      # @param [String] path the URI path to perform the request against
      # @param [Hash] params
      # @option params [String] :sd The start date in format dd/mm/yyyy
      # @option params [String] :st The start time, 0 spaced: 00-23
      # @option params [Integer] :duration The duration for the code to be valid for
      #
      # @return [Codelocks::NetCode::Response]

      def create(path, params = {})
        response = Codelocks.connection.get(path, default_params.merge(params)) do |req|
          req.headers['x-api-key'] = Codelocks.api_key
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
