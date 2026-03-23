# philiprehberger-phone

[![Tests](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-phone.svg)](https://rubygems.org/gems/philiprehberger-phone)
[![License](https://img.shields.io/github/license/philiprehberger/rb-phone)](LICENSE)

Lightweight phone number parsing, validation, and formatting.

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem 'philiprehberger-phone'
```

Or install directly:

```sh
gem install philiprehberger-phone
```

## Usage

```ruby
require 'philiprehberger/phone'

phone = Philiprehberger::Phone.parse('+1 (555) 123-4567')
phone.valid?        # => true
phone.country_code  # => "1"
phone.national      # => "5551234567"
phone.country       # => :us
phone.e164          # => "+15551234567"
```

### Formatting

```ruby
phone = Philiprehberger::Phone.parse('+15551234567')
phone.formatted      # => "(555) 123-4567"
phone.international  # => "+1 (555) 123-4567"
phone.e164           # => "+15551234567"
```

### Country Hint

```ruby
phone = Philiprehberger::Phone.parse('020 7946 0958', country: :gb)
phone.country_code  # => "44"
phone.country       # => :gb
```

### Validation

```ruby
Philiprehberger::Phone.valid?('+44 20 7946 0958')  # => true
Philiprehberger::Phone.valid?('+1 555')             # => false
```

### Supported Countries

US, CA, GB, DE, FR, AU, JP, IN, BR.

## API

### `Philiprehberger::Phone`

| Method | Description |
|--------|-------------|
| `.parse(input, country: nil)` | Parse a phone number string into a `PhoneNumber` |
| `.valid?(input, country: nil)` | Check if a phone number is valid |

### `Philiprehberger::Phone::PhoneNumber`

| Method | Description |
|--------|-------------|
| `#valid?` | Whether the number matches country length rules |
| `#country_code` | Numeric country calling code (e.g. "1", "44") |
| `#national` | National number digits only |
| `#e164` | E.164 format ("+15551234567") |
| `#formatted` | Country-specific national format |
| `#international` | International format with country code |
| `#country` | Country symbol (e.g. `:us`, `:gb`) |

## Development

```sh
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT License. See [LICENSE](LICENSE) for details.
