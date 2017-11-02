require "spec_helper"

describe Codelocks::Request do
  let(:client) do
    Codelocks::Client.new(
      base_uri: ENV["CODELOCKS_BASE_URI"] || "wibble",
      api_key: ENV["CODELOCKS_API_KEY"] || "wobble"
    )
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
      allow(client.connection).to receive(:get) { response }
      allow(client.requests.model).to receive(:default_params) { default_params }
    end


    it "performs a get request" do
      expect(client.connection).to receive(:get).with(path, all_params)
      client.requests.create(path, params)
    end

    it "returns a response object" do
      expect(
        client.requests.create(path, params)
      ).to be_a(Codelocks::Response)
    end
  end
end
