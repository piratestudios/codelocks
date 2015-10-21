require "spec_helper"

describe Codelocks::NetCode do
  describe "#generate_netcode" do
    let(:lock_id) { nil }
    let(:start_time) { Time.now }
    let(:duration) { 1 }

    subject { Codelocks::NetCode.generate_netcode(lock_id: lock_id, start_time: start_time, duration: duration) }

    before do
      Codelocks.api_key = ENV['CODELOCKS_API_KEY'] || "wibble"
      Codelocks.pairing_id = ENV['CODELOCKS_PAIRING_ID'] || "wobble"
    end

    context "valid lock ID" do
      let(:lock_id) { ENV['CODELOCKS_LOCK_ID'] || "valid" }

      around(:each) do |example|
        VCR.use_cassette("valid_lock_id", erb: true, match_requests_on: [:method]) do
          example.run
        end
      end

      it { is_expected.to be_a(Codelocks::NetCode::Response) }

      it "is successful" do
        expect(subject.success?).to be true
      end

      it "returns a valid netcode" do
        expect(subject.netcode).to be_a(String)
      end

      it "returns a valid starttime" do
        expect(subject.starttime).to be_a(String)
      end

      it "doesn't return an error" do
        expect(subject.error).to be nil
      end
    end

    context "invalid lock ID" do
      let(:lock_id) { "invalid" }

      around(:each) do |example|
        VCR.use_cassette("invalid_lock_id", erb: true, match_requests_on: [:method]) do
          example.run
        end
      end

      it { is_expected.to be_a(Codelocks::NetCode::Response) }

      it "returns an error" do
        expect(subject.error).to be_a(String)
      end

      it "returns an error message" do
        expect(subject.message).to be_a(String)
      end
    end
  end

  describe '#convert_duration' do
    subject { Codelocks::NetCode.send(:convert_duration, duration) }
    let(:duration) { rand(0..169) }

    it "doesn't return an error" do
      expect { subject }.not_to raise_error
    end

    it "returns an integer" do
      expect(subject).to be_a(Integer)
    end
  end
end
