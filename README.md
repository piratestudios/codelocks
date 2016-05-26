# Codelocks

[![Gem Version](https://badge.fury.io/rb/codelocks.svg)](https://badge.fury.io/rb/codelocks)

A simple gem to wrap the Codelocks NetCode API, for generating key codes to operate their physical locks.

# API Versions

If you are using an API version prior to v4.1, you need to use the latest v1 release of this gem.
v2 is a large rewrite in order to support the new API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codelocks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codelocks

## Usage

Configure your API credentials, either by setting the following two environment variables:

```
CODELOCKS_BASE_URI
CODELOCKS_API_KEY
CODELOCKS_ACCESS_KEY
```

Or by setting them directly in Ruby:

```ruby
Codelocks.base_uri = "http://something.com"
Codelocks.api_key = "blargh"
Codelocks.access_key = "argh"
```

API documentation with information on methods is [available on RubyDoc.info](http://www.rubydoc.info/github/kansohq/codelocks/master).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/codelocks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
