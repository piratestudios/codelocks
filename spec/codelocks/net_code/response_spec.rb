require "spec_helper"

describe Codelocks::NetCode::Response do
  let(:response) { Codelocks::NetCode::Response.new(faraday_response) }
  let(:faraday_response) { double('faraday_response', success?: true, body: '{"test": "thing"}') }

  before do
    Codelocks.api_key = "wibble"
    Codelocks.pairing_id = "wobble"
  end

  describe "#initialize" do
    it "sets the response instance variable" do
      expect(response.response).to eq(faraday_response)
    end
  end

  describe "#success?" do
    subject { response.success? }

    context "is a success" do
      before { allow(faraday_response).to receive(:success?) { true } }

      it { is_expected.to be true }
    end

    context "is not a success" do
      before { allow(faraday_response).to receive(:success?) { false } }

      it { is_expected.to be false }
    end
  end

  describe "#body" do
    subject { response.body }

    context "success? is true" do
      before { allow(faraday_response).to receive(:success?) { true } }

      it { is_expected.to be_a(Hash) }
    end

    context "success? is false" do
      before { allow(faraday_response).to receive(:success?) { false } }

      it { is_expected.to be nil }
    end
  end

  describe "#method_missing" do
    it "returns the value from the body hash" do
      expect(response.test).to eq("thing")
    end

    it "returns nil for missing keys" do
      expect(response.blargh).to be nil
    end
  end
end
