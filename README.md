# mongostat

This is a simple ruby wrapper around `mongostat` utility function. This is very much inspired by
the good work of https://gist.github.com/jtushman/3013625.

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

# start will block, so open it in a new thread
Thread.new("mongostat") do
  # host, username and password are optional
  Mongostat.start({:host => "", :username => "", :password => ""})
end

loop do
  puts Mongostat.read
end

# outputs
{
    "dbname"=>"localhost:27017",
    "insert"=>"*0",
    "query"=>"*0",
    "update"=>"*0",
    "delete"=>"*0",
    "getmore"=>"0",
    "command"=>"7|0",
    "flushes"=>"0",
    "mapped"=>"624m",
    "vsize"=>"1.45g",
    "res"=>"228m",
    "faults"=>"0",
    "locked"=>"local:0.0%",
    "idxmiss"=>"0",
    "qr|qw"=>"0|0",
    "ar|aw"=>"0|0",
    "netIn"=>"434b",
    "netOut"=>"21k",
    "conn"=>"20",
    "time"=>"16:12:50"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
