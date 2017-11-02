module Codelocks
  class CollectionProxy
    extend Forwardable

    # @return [Client]
    attr_accessor :client

    # @return [Lock, NetCode, Request]
    attr_accessor :model

    def_delegators :@model, :create, :all

    # Set configuration variables on instantiation
    #
    # @return [Codelocks::CollectionProxy]

    def initialize(client: nil, model: nil)
      self.client = client
      self.model = model

      model.collection_proxy = self

      self
    end
  end
end
