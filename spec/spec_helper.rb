require "dotenv"
Dotenv.load

require "codelocks"
require "vcr"
require "pry"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :faraday
  config.filter_sensitive_data("<BASE_URI>") { ENV['CODELOCKS_BASE_URI'] }
  config.filter_sensitive_data("<API_KEY>") { ENV['CODELOCKS_API_KEY'] }
  config.filter_sensitive_data("<ACCESS_KEY>") { ENV['CODELOCKS_ACCESS_KEY'] }
  config.filter_sensitive_data("LOCK_ID") { ENV['CODELOCKS_LOCK_ID'] }
end
