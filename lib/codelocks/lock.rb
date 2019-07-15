module Codelocks
  class Lock < Model
    class << self
      # Fetch a list of locks. Requires the access key env var to be set
      #
      # @return [Codelocks::NetCode::Response]

      def all
        super

        client.requests.create("k3connect",
          "accesskey": client.access_key
        )
      end
    end
  end
end
