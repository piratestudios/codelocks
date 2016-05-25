require "spec_helper"

describe Codelocks::NetCode::Request do
  before do
    Codelocks.base_uri = "http://wobble.com/"
    Codelocks.api_key = "wibble"
  end

  describe "#create" do
    let(:params) do
      { id: "lock" }
    end

    let(:default_params) do
      {}
    end

    let(:all_params) { default_params.merge(params) }

    let(:response) { double('faraday_response') }
    let(:path) { "netcode/#{params[:id]}" }

    before do
      allow(Codelocks.connection).to receive(:get) { response }
      allow(Codelocks::NetCode::Request).to receive(:default_params) { default_params }
    end


    it "performs a get request" do
      expect(Codelocks.connection).to receive(:get).with(path, all_params)
      Codelocks::NetCode::Request.create(path, params)
    end

    it "returns a response object" do
      expect(
        Codelocks::NetCode::Request.create(path, params)
      ).to be_a(Codelocks::NetCode::Response)
    end
  end
end
