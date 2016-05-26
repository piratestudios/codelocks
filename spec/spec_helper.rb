require "dotenv"
Dotenv.load

require "codelocks"
require "vcr"
require "pry"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :faraday
  config.filter_sensitive_data("<BASE_URI>") { Codelocks.base_uri }
  config.filter_sensitive_data("<API_KEY>") { Codelocks.api_key }
  config.filter_sensitive_data("<ACCESS_KEY>") { Codelocks.access_key }
  config.filter_sensitive_data("<LOCK_ID>") { ENV['CODELOCKS_LOCK_ID'] }
end
