module Codelocks
  class Lock
    class << self
      # Fetch a list of locks. Requires the access key env var to be set
      #
      # @return [Codelocks::NetCode::Response]

      def all
        if !Codelocks.access_key
          raise CodelocksError.new("An access key must be provided")
        end

        Request.create("lock",
          "accesskey": Codelocks.access_key
        )
      end
    end
  end
end
