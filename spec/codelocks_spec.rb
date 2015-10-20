require "spec_helper"

describe Codelocks do
  describe "#base_uri" do
    subject { Codelocks.base_uri }

    it { is_expected.to be_a(String) }
  end

  describe "#api_key" do
    subject { Codelocks.api_key }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { Codelocks.api_key = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { Codelocks.api_key = nil }

      it "raises an exception" do
        expect { subject }.to raise_error(Codelocks::CodelocksError)
      end
    end
  end

  describe "#pairing_id" do
    subject { Codelocks.pairing_id }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { Codelocks.pairing_id = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { Codelocks.pairing_id = nil }

      it "raises an exception" do
        expect { subject }.to raise_error(Codelocks::CodelocksError)
      end
    end
  end

  describe "#connection" do
    subject { Codelocks.connection }

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
