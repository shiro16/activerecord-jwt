# ActiveRecord::Jwt

This ActiveRecord extension adds jwt(JSON Web Token) method


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-jwt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord-jwt

## Example Usage

### ActiveRecord::Jwt::Encoder

```ruby
require 'activerecord-jwt'

ActiveRecord::Jwt::Encoder.configure do |config|
  config.key = 'secret_key'
end

class User < ActiveRecord::Base
  include ActiveRecord::Jwt::Encoder
end

user = User.create(name: 'encoder')

# eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTQ0MTg5MjU5NCwiaXNzIjoiaXNzdWVyIiwiYXVkIjoiYXVkaWVuY2UiLCJpYXQiOjE0NDE4OTE5OTQsImNsYXNzIjoiVXNlciJ9.bxyGTmqFY6iwXpRY4QEolrHP-qy0k59wUqGpVKss2Yk
token = user.jwt
```

### ActiveRecord::Jwt::Decoder

```ruby
require 'activerecord-jwt'

class User < ActiveRecord::Base
  include ActiveRecord::Jwt::Decoder
end

ActiveRecord::Jwt::Decoder.configure do |config|
  config.key = 'secret_key'
end

User.decode_jwt(token)
# Hash
# {
#   payload: {"sub"=>1, "exp"=>1441892594, "iss"=>"issuer", "aud"=>"audience", "iat"=>1441891994, "class"=>"User"},
#   header: {"typ"=>"JWT", "alg"=>"HS256"}
# }

User.find_authenticated_jwt(token)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

