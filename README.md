# Mail Verifier

MailVerifier was inspired in [kamil/email_verifier](https://github.com/kamilc/email_verifier), but without the whole shebang.

This is straight to the point, require the gem and do your verification. No Railsties and other bangs. Also, no external deps, pure Ruby good ol' StdLib.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mail_verifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mail_verifier

## Usage

```ruby
require "mail_verifier"
MailVerifier.verify("origin_valid_mail@example.com", "mail_you_want_to_check@example.com")
```

Some domains check back if your domain is valid, therefore you need to provide a valid email (`origin_valid_mail`) first.

As for the destination mail, of course it _can_ be invalid, we don't know. This is why we check, right? :D

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mail_verifier.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

