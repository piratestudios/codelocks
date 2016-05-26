module Codelocks
  class Lock
    class << self
      # Fetch a list of locks
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
