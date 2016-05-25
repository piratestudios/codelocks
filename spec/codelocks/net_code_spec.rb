require "spec_helper"

describe Codelocks::NetCode do
  describe ".generate_netcode" do
    let(:lock_id) { nil }
    let(:start_time) { Time.now }
    let(:duration) { 1 }

    subject { Codelocks::NetCode.generate_netcode(lock_id: lock_id, start_time: start_time, duration: duration) }

    before do
      Codelocks.base_uri = ENV["CODELOCKS_BASE_URI"] || "wibble"
      Codelocks.api_key = ENV["CODELOCKS_API_KEY"] || "wobble"
      Codelocks.access_key = ENV["CODELOCKS_ACCESS_KEY"] || "wubble"
    end

    context "valid lock ID" do
      let(:lock_id) { ENV["CODELOCKS_LOCK_ID"] || "valid" }

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

  let(:lock_id) { "001" }
  let(:start) { Time.new(2016, 1, 1, 14, 0, 0) }
  let(:duration) { 0 }
  let(:urm) { false }

  subject(:netcode) { Codelocks::NetCode.new(lock_id: lock_id, start: start, duration: duration, urm: urm) }

  describe "#lock_id" do
    subject { netcode.lock_id }
    it { is_expected.to eq "N001" }
  end

  describe "#start_date" do
    subject { netcode.start_date }
    it { is_expected.to eq "2016-01-01" }
  end

  describe "#start_time" do
    subject { netcode.start_time }

    context "URM disabled and any duration ID" do
      let(:urm) { false }
      before { allow(netcode).to receive(:duration_id) { 31 } }
      it { is_expected.to eq "14:00" }
    end

    context "URM enabled and duration ID under 31" do
      let(:urm) { true }
      before { allow(netcode).to receive(:duration_id) { 30 } }
      it { is_expected.to eq "14:00" }
    end

    context "URM enabled and duration ID over 30" do
      let(:urm) { true }
      before { allow(netcode).to receive(:duration_id) { 31 } }
      it { is_expected.to eq "00:00" }
    end
  end

  describe "#start_datetime" do
    subject { netcode.start_datetime }
    it { is_expected.to eq("2016-01-01 14:00") }
  end

  describe "#duration_id" do
    context "URM disabled" do
      let(:urm) { false }

      context "zero duration" do
        it "return 0" do
          allow(netcode).to receive(:duration) { 0 }
          expect(netcode.duration_id).to eq 0
        end
      end

      context "up to half a day" do
        it "returns minus one from the duration" do
          (1..12).each do |i|
            allow(netcode).to receive(:duration) { i }
            expect(netcode.duration_id).to eq i - 1
          end
        end
      end

      context "whole days" do
        it "returns number of days counting from 11" do
          (1..7).each do |i|
            allow(netcode).to receive(:duration) { i * 24 }
            expect(netcode.duration_id).to eq 11 + i
          end
        end
      end

      context "over 7 days" do
        it "returns 18" do
          allow(netcode).to receive(:duration) { 8 * 24 }
          expect(netcode.duration_id).to eq 18
        end
      end
    end

    context "URM enabled" do
      let(:urm) { true }

      context "zero duration" do
        it "return 19" do
          allow(netcode).to receive(:duration) { 0 }
          expect(netcode.duration_id).to eq 19
        end
      end

      context "up to half a day" do
        it "returns 19 minus one from the duration" do
          (1..12).each do |i|
            allow(netcode).to receive(:duration) { i }
            expect(netcode.duration_id).to eq 19 + i - 1
          end
        end
      end

      context "whole days" do
        it "returns number of days counting from 30" do
          (1..7).each do |i|
            allow(netcode).to receive(:duration) { i * 24 }
            expect(netcode.duration_id).to eq 19 + 11 + i
          end
        end
      end

      context "over 7 days" do
        it "returns 37" do
          allow(netcode).to receive(:duration) { 8 * 24 }
          expect(netcode.duration_id).to eq 19 + 18
        end
      end
    end
  end

  describe "#urm?" do
    subject { netcode.urm? }

    context "URM disabled" do
      let(:urm) { false }
      it { is_expected.to eq false }
    end

    context "URM enabled" do
      let(:urm) { true }
      it { is_expected.to eq true }
    end
  end
end
