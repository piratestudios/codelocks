require 'spec_helper'

describe Codelocks::CollectionProxy do
  subject(:proxy) { Codelocks::CollectionProxy.new(model: model, client: client) }
  let(:client) { Codelocks::Client.new }
  let(:model) { Codelocks::Model }

  describe "attribute accessors" do
    [:client, :model].each do |attr|
      it { is_expected.to respond_to(attr) }
      it { is_expected.to respond_to(:"#{attr}=") }
    end
  end

  describe "#initialize" do
    subject { proxy.send(:initialize, client: client, model: model) }

    after { subject }

    it "sets the client" do
      expect(proxy).to receive(:client=).with(client)
    end

    it "sets the model" do
      expect(proxy).to receive(:model=).with(model)
    end

    it "sets itself as the model's proxy" do
      expect(model).to receive(:collection_proxy=).with(proxy)
    end
  end
end
