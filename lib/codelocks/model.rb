module Codelocks
  class Model
    extend Forwardable

    def_delegator :@class, :client

    class << self
      extend Forwardable

      # @return [CollectionProxy]
      attr_accessor :collection_proxy

      def_delegator :@collection_proxy, :client

      def all
        if !client.access_key
          raise CodelocksError.new("An access key must be provided")
        end
      end

      def create
      end
    end
  end
end
