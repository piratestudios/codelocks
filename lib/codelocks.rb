require "codelocks/version"
require "faraday"

module Codelocks
  class CodelocksError < StandardError; end

  class << self
    attr_writer :api_key, :pairing_id

    # The base URI used for API request
    #
    # @return [String] the base URI

    def base_uri
      "https://api-2445581366752.apicast.io/api/v3"
    end

    # Return the configured API key or raise an exception
    #
    # @return [String] the API key

    def api_key
      @api_key || (raise CodelocksError.new("No API key specified"))
    end

    # Return the configured pairing ID or raise an exception
    #
    # @return [String] the pairing ID

    def pairing_id
      @pairing_id || (raise CodelocksError.new("No pairing ID specified"))
    end

    # Faraday connection object
    #
    # @return [Faraday]

    def connection
      @connection ||= Faraday.new(url: base_uri) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
