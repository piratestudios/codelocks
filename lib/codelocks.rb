require "faraday"

require "codelocks/version"
require "codelocks/request"
require "codelocks/response"
require "codelocks/lock"
require "codelocks/net_code"

module Codelocks
  class CodelocksError < StandardError; end

  class << self
    attr_writer :base_uri, :api_key, :access_key

    # The base URI used for API request
    #
    # @return [String] the base URI

    def base_uri
      @base_uri || ENV['CODELOCKS_BASE_URI'] || (raise CodelocksError.new("No base URI specified"))
    end

    # Return the configured API key or raise an exception
    #
    # @return [String] the API key

    def api_key
      @api_key || ENV['CODELOCKS_API_KEY'] || (raise CodelocksError.new("No API key specified"))
    end

    # Return the access key. This is tied to the K3 Connect App.
    # This can be nil, as for certain models of locks you will provide a 6 digit ID instead.
    #
    # @return [String] the access key

    def access_key
      @access_key || ENV['CODELOCKS_ACCESS_KEY']
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
