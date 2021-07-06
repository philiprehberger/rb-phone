# philiprehberger-phone

[![Tests](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml) [![Gem Version](https://img.shields.io/gem/v/philiprehberger-phone)](https://rubygems.org/gems/philiprehberger-phone) [![GitHub release](https://img.shields.io/github/v/release/philiprehberger/rb-phone)](https://github.com/philiprehberger/rb-phone/releases) [![GitHub last commit](https://img.shields.io/github/last-commit/philiprehberger/rb-phone)](https://github.com/philiprehberger/rb-phone/commits/main) [![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) [![Bug Reports](https://img.shields.io/badge/bug-reports-red.svg)](https://github.com/philiprehberger/rb-phone/issues) [![Feature Requests](https://img.shields.io/badge/feature-requests-blue.svg)](https://github.com/philiprehberger/rb-phone/issues) [![GitHub Sponsors](https://img.shields.io/badge/sponsor-philiprehberger-ea4aaa.svg?logo=github)](https://github.com/sponsors/philiprehberger)

Lightweight phone number parsing, validation, formatting, and metadata lookup for 36 countries.

## Requirements

- Ruby >= 3.1

## Installation

Add to your Gemfile:

```ruby
gem "philiprehberger-phone"
```

Or install directly:

```bash
gem install philiprehberger-phone
```

## Usage

### Parsing and Formatting

```ruby
require "philiprehberger/phone"

phone = Philiprehberger::Phone.parse("+1 (555) 123-4567")
phone.valid?        # => true
phone.country_code  # => "1"
phone.national      # => "5551234567"
phone.country       # => :us
phone.e164          # => "+15551234567"
phone.formatted     # => "(555) 123-4567"
phone.international # => "+1 (555) 123-4567"
```

### Country Hint

```ruby
phone = Philiprehberger::Phone.parse("020 7946 0958", country: :gb)
phone.country_code  # => "44"
phone.country       # => :gb
```

### Validation

```ruby
Philiprehberger::Phone.valid?("+44 20 7946 0958")  # => true
Philiprehberger::Phone.valid?("+1 555")             # => false
```

### Phone Type Detection

```ruby
phone = Philiprehberger::Phone.parse("+18001234567")
phone.phone_type  # => :toll_free

phone = Philiprehberger::Phone.parse("+447911123456")
phone.phone_type  # => :mobile

phone = Philiprehberger::Phone.parse("+19001234567")
phone.phone_type  # => :premium
```

### Area Code Lookup

```ruby
phone = Philiprehberger::Phone.parse("+12125551234")
phone.area_code_info  # => { area_code: "212", region: "New York, NY" }

phone = Philiprehberger::Phone.parse("+442079460958")
phone.area_code_info  # => { area_code: "20", region: "London" }
```

### Vanity Number Conversion

```ruby
Philiprehberger::Phone.vanity_to_digits("1-800-FLOWERS")  # => "18003569377"
Philiprehberger::Phone.vanity_to_digits("1-800-COLLECT")  # => "18002655328"
```

### SMS Shortcode Validation

```ruby
Philiprehberger::Phone.valid_shortcode?("12345", country: :us)   # => true
Philiprehberger::Phone.valid_shortcode?("123456", country: :us)  # => true
Philiprehberger::Phone.valid_shortcode?("1234", country: :us)    # => false
```

### Carrier Identification

```ruby
phone = Philiprehberger::Phone::PhoneNumber.new(country_code: "1", national: "2125551234", country: :us)
phone.carrier  # => "AT&T"
```

### Supported Countries

US, CA, GB, DE, FR, AU, JP, IN, BR, MX, ES, IT, NL, BE, CH, AT, SE, NO, DK, FI, PL, PT, IE, RU, CN, KR, SG, NZ, ZA, NG, KE, EG, AR, CL, CO, PE.

## API

### `Philiprehberger::Phone`

| Method | Description |
|--------|-------------|
| `.parse(input, country: nil)` | Parse a phone number string into a `PhoneNumber` |
| `.valid?(input, country: nil)` | Check if a phone number is valid |
| `.vanity_to_digits(input)` | Convert vanity letters to digits (e.g. "1-800-FLOWERS") |
| `.valid_shortcode?(input, country: :us)` | Validate an SMS shortcode for a country |

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
| `#phone_type` | Phone type: `:mobile`, `:landline`, `:toll_free`, `:premium`, `:unknown` |
| `#area_code_info` | Area code metadata `{ area_code:, region: }` for US/CA/GB/DE |
| `#carrier` | Carrier name based on prefix (US only) |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Philip%20Rehberger-blue?logo=linkedin)](https://linkedin.com/in/philiprehberger) [![More Packages](https://img.shields.io/badge/more-packages-blue.svg)](https://github.com/philiprehberger?tab=repositories)

## License

[MIT](LICENSE)
