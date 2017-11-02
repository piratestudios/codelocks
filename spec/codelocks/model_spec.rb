require 'spec_helper'

describe Codelocks::Model do
  let(:client) { Codelocks::Client.new }
  let(:proxy) { Codelocks::CollectionProxy.new(model: Codelocks::Model, client: client) }

  before do
    Codelocks::Model.collection_proxy = proxy
  end

  describe "instance methods" do
    subject(:model) { Codelocks::Model.new }

    describe "#client" do
      subject { model.client }

      it { is_expected.to eq(client) }
    end
  end

  describe "class methods" do
    subject { Codelocks::Model }

    describe ".all" do
      it { is_expected.to respond_to(:all) }

      context "access key isn't set" do
        before { allow(client).to receive(:access_key) { nil } }

        it "raises an error" do
          expect { subject.all }.to raise_error(Codelocks::CodelocksError)
        end
      end
    end

    describe ".create" do
      it { is_expected.to respond_to(:create) }
    end
  end
end
