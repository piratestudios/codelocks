# Codelocks

[![Gem Version](https://badge.fury.io/rb/codelocks.svg)](https://badge.fury.io/rb/codelocks)

A simple gem to wrap the Codelocks NetCode API, for generating key codes to operate their physical locks.

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
CODELOCKS_API_KEY
CODELOCKS_PAIRING_ID
```

Or by setting them directly in Ruby:

```ruby
Codelocks.api_key = "blargh"
Codelocks.pairing_id = "argh"
```

API documentation with information on methods is [available on RubyDoc.info](http://www.rubydoc.info/github/kansohq/codelocks/master).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/codelocks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
