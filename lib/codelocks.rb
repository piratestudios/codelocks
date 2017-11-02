require "faraday"

require "codelocks/version"
require "codelocks/client"
require "codelocks/collection_proxy"
require "codelocks/model"
require "codelocks/request"
require "codelocks/response"
require "codelocks/lock"
require "codelocks/net_code"

module Codelocks
  class CodelocksError < StandardError; end
end
