# mongostat

This is a simple ruby wrapper around `mongostat` utility function.

## Installation

Add this line to your application's Gemfile:

    gem 'mongostat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongostat

## Usage

```ruby
require "mongostat"
result = Mongostat.run({:host => "", :username => "", :password => ""})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
