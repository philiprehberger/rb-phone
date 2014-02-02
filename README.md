# philiprehberger-phone

[![Tests](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-phone.svg)](https://rubygems.org/gems/philiprehberger-phone)
[![License](https://img.shields.io/github/license/philiprehberger/rb-phone)](LICENSE)

Lightweight phone number parsing, validation, and formatting

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem 'philiprehberger-phone'
```

Or install directly:

```bash
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
```

### Formatting

```ruby
phone = Philiprehberger::Phone.parse('+15551234567')
phone.format(:national)       # => "(555) 123-4567"
phone.format(:international)  # => "+1 (555) 123-4567"
phone.format(:e164)           # => "+15551234567"
```

### Country Hint

```ruby
phone = Philiprehberger::Phone.parse('02079460958', country: :gb)
phone.country_code  # => "44"
phone.country       # => :gb
```

### Validation

```ruby
Philiprehberger::Phone.valid?('+44 20 7946 0958')  # => true
Philiprehberger::Phone.valid?('+1 555')             # => false
```

### International Numbers

```ruby
Philiprehberger::Phone.parse('+4930123456789')  # Germany
Philiprehberger::Phone.parse('+81312345678')    # Japan
Philiprehberger::Phone.parse('+61412345678')    # Australia
```

## API

### `Philiprehberger::Phone`

| Method | Description |
|--------|-------------|
| `.parse(number, country:)` | Parse a phone number string into a `Number` object |
| `.valid?(number, country:)` | Check if a phone number is valid |

### `Philiprehberger::Phone::Number`

| Method | Description |
|--------|-------------|
| `#valid?` | Whether the number matches country length rules |
| `#country_code` | The numeric country calling code |
| `#national` | The national number digits |
| `#country` | Country symbol (e.g., `:us`, `:gb`) |
| `#e164` | E.164 format (`+15551234567`) |
| `#format(style)` | Format as `:national`, `:international`, or `:e164` |
| `#formatted` | National format shortcut |
| `#international` | International format shortcut |
| `#type` | Number type (`:mobile`, `:landline`, or `:unknown`) |

## Development

```bash
bundle install
bundle exec rspec      # Run tests
bundle exec rubocop    # Check code style
```

## License

MIT
