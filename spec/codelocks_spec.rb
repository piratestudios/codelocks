require "spec_helper"

describe Codelocks do
  describe "#base_uri" do
    subject { Codelocks.base_uri }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { Codelocks.base_uri = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { Codelocks.base_uri = nil }

      it "raises an exception" do
        expect { subject }.to raise_error(Codelocks::CodelocksError)
      end
    end
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

  describe "#access_key" do
    subject { Codelocks.access_key }

    before { allow(ENV).to receive(:[]) { nil } }

    context "is present" do
      before { Codelocks.access_key = "test" }

      it { is_expected.to eq("test") }
    end

    context "is not present" do
      before { Codelocks.access_key = nil }

      it { is_expected.to eq(nil) }
    end
  end


  describe "#connection" do
    subject { Codelocks.connection }

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
