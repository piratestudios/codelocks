require 'spec_helper'

describe Codelocks::Client do
  subject(:client) do
    Codelocks::Client.new(
      base_uri: ENV["CODELOCKS_BASE_URI"] || "wibble",
      api_key: ENV["CODELOCKS_API_KEY"] || "wobble"
    )
  end

  describe "#base_uri" do
    subject { client.base_uri }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { client.base_uri = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { client.base_uri = nil }

      it "raises an exception" do
        expect { subject }.to raise_error(Codelocks::CodelocksError)
      end
    end
  end

  describe "#api_key" do
    subject { client.api_key }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { client.api_key = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { client.api_key = nil }

      it "raises an exception" do
        expect { subject }.to raise_error(Codelocks::CodelocksError)
      end
    end
  end

  describe "#access_key" do
    subject { client.access_key }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { client.access_key = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { client.access_key = nil }

      it { is_expected.to eq(nil) }
    end
  end

  describe "#connection" do
    subject { client.connection }

    it { is_expected.to be_a(Faraday::Connection) }
  end

  describe "#requests" do
    subject { client.requests }

    it { is_expected.to be_a(Codelocks::CollectionProxy) }
  end

  describe "#net_codes" do
    subject { client.net_codes }

    it { is_expected.to be_a(Codelocks::CollectionProxy) }
  end

  describe "#locks" do
    subject { client.locks }

    it { is_expected.to be_a(Codelocks::CollectionProxy) }
  end
end
