require "spec_helper"

describe Codelocks::Lock do
  let(:client) do
    Codelocks::Client.new(
      base_uri: ENV["CODELOCKS_BASE_URI"] || "wibble",
      api_key: ENV["CODELOCKS_API_KEY"] || "wobble"
    )
  end

  describe ".all" do
    subject { client.locks.all }

    context "valid access key" do
      before do
        client.access_key = ENV["CODELOCKS_ACCESS_KEY"] || "wubble"
      end

      around(:each) do |example|
        VCR.use_cassette("valid_access_key", erb: true, match_requests_on: [:method]) do
          example.run
        end
      end

      it { is_expected.to be_a(Codelocks::Response) }

      it "is successful" do
        expect(subject.success?).to be true
      end

      it "doesn't return an error" do
        expect(subject.error_message).to be nil
      end
    end

    context "invalid access key" do
      before do
        client.access_key = "abracadabra"
      end

      around(:each) do |example|
        VCR.use_cassette("invalid_access_key", erb: true, match_requests_on: [:method]) do
          example.run
        end
      end

      it { is_expected.to be_a(Codelocks::Response) }

      it "returns an error" do
        expect(subject.error_message).to be_a(String)
      end
    end
  end
end
