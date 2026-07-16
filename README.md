# philiprehberger-phone

[![Tests](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml/badge.svg)](https://github.com/philiprehberger/rb-phone/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/philiprehberger-phone.svg)](https://rubygems.org/gems/philiprehberger-phone)
[![Last updated](https://img.shields.io/github/last-commit/philiprehberger/rb-phone)](https://github.com/philiprehberger/rb-phone/commits/main)

![philiprehberger-phone](https://raw.githubusercontent.com/philiprehberger/rb-phone/main/package-card.webp)

Lightweight phone number parsing, validation, formatting, and metadata lookup for 36 countries

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
phone.country_name  # => "United States"
```

### Country Hint

```ruby
phone = Philiprehberger::Phone.parse("020 7946 0958", country: :gb)
phone.country_code  # => "44"
phone.country       # => :gb
phone.e164          # => "+442079460958"
```

A national trunk `0` (used by most of Europe, Australia, and others) is dropped
when composing the E.164 number. It is preserved for NANP (`+1`) and for plans
where a leading `0` is significant.

### One-shot Formatting

Skip the explicit `PhoneNumber` instance when you just need a string:

```ruby
Philiprehberger::Phone.format("4155551212", format: :e164, country: :us)
# => "+14155551212"

Philiprehberger::Phone.format("4155551212", format: :international, country: :us)
# => "+1 415 555 1212"
```

Accepted formats: `:e164`, `:national`, `:international`.

### Validation

```ruby
Philiprehberger::Phone.valid?("+44 20 7946 0958")  # => true
Philiprehberger::Phone.valid?("+1 555")             # => false
```

### Country Detection

`Phone.country_of` returns the country symbol for a number (or `nil`) without raising:

```ruby
Philiprehberger::Phone.country_of("+15551234567")               # => :us
Philiprehberger::Phone.country_of("020 7946 0958", country: :gb)  # => :gb
Philiprehberger::Phone.country_of("garbage")                    # => nil
```

The shared NANP `+1` code is disambiguated between the US and Canada by the
3-digit area code, so Canadian numbers resolve to `:ca` (and get correct
area-code and carrier lookups):

```ruby
Philiprehberger::Phone.country_of("+14161234567")  # => :ca (Toronto)
Philiprehberger::Phone.country_of("+12125551234")  # => :us (New York)
```

### Phone Type Detection

```ruby
phone = Philiprehberger::Phone.parse("+18001234567")
phone.phone_type  # => :toll_free

phone = Philiprehberger::Phone.parse("+447911123456")
phone.phone_type  # => :mobile

phone = Philiprehberger::Phone.parse("+19001234567")
phone.phone_type  # => :premium

phone = Philiprehberger::Phone.parse("+18001234567")
phone.toll_free?  # => true
phone.mobile?     # => false
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
Philiprehberger::Phone.valid_shortcode?("12345", country: :br)  # => true
Philiprehberger::Phone.valid_shortcode?("1234", country: :kr)   # => true
```

Supported shortcode countries: US, CA, GB, DE, FR, AU, IN, BR, MX, JP, KR, IT, ES.

### Similar Comparison

```ruby
a = Philiprehberger::Phone.parse("+1 (555) 123-4567")
b = Philiprehberger::Phone.parse("+1-555-123-4567")

a.similar_to?(b)  # => true (same E.164: "+15551234567")
a == b             # => true

c = Philiprehberger::Phone.parse("+44 20 7946 0958")
a.similar_to?(c)   # => false
```

`PhoneNumber` also implements `eql?` and `hash` (both keyed off E.164), so equal
numbers dedupe in a `Set` and collapse as `Hash` keys regardless of formatting:

```ruby
require "set"

a = Philiprehberger::Phone.parse("+1 (555) 123-4567")
b = Philiprehberger::Phone.parse("+1-555-123-4567")

Set.new([a, b]).size          # => 1
{ a => "primary" }[b]         # => "primary"
```

### Carrier Identification

Carrier lookup is supported for US, CA, GB, and DE.

```ruby
phone = Philiprehberger::Phone::PhoneNumber.new(country_code: "1", national: "2125551234", country: :us)
phone.carrier  # => "AT&T"

phone = Philiprehberger::Phone::PhoneNumber.new(country_code: "1", national: "4161234567", country: :ca)
phone.carrier  # => "Rogers"
```

### Country Name

```ruby
phone = Philiprehberger::Phone.parse("+15551234567")
phone.country_name  # => "United States"

phone = Philiprehberger::Phone.parse("+442079460958")
phone.country_name  # => "United Kingdom"
```

### Masking

```ruby
phone = Philiprehberger::Phone.parse("+15551234567")
phone.masked              # => "+1******4567"
phone.masked(visible: 0)  # => "+1**********"
phone.masked(visible: 99) # => "+15551234567"
```

### Serialization

```ruby
phone = Philiprehberger::Phone.parse("+15551234567")
phone.to_h
# => { country_code: "1", national: "5551234567", country: :us, ... }
```

### Supported Countries

US, CA, GB, DE, FR, AU, JP, IN, BR, MX, ES, IT, NL, BE, CH, AT, SE, NO, DK, FI, PL, PT, IE, RU, CN, KR, SG, NZ, ZA, NG, KE, EG, AR, CL, CO, PE.

## API

### `Philiprehberger::Phone`

| Method | Description |
|--------|-------------|
| `.parse(input, country: nil)` | Parse a phone number string into a `PhoneNumber` |
| `.valid?(input, country: nil)` | Check if a phone number is valid |
| `.country_of(input, country: nil)` | Country symbol (or `nil`) — non-raising convenience |
| `.vanity_to_digits(input)` | Convert vanity letters to digits (e.g. "1-800-FLOWERS") |
| `.valid_shortcode?(input, country: :us)` | Validate an SMS shortcode for a country |
| `.format(input, format:, country: nil)` | Parse and format in one call; `format:` accepts `:e164`, `:national`, or `:international` |

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
| `#mobile?` | Whether the number is a mobile line |
| `#landline?` | Whether the number is a landline |
| `#toll_free?` | Whether the number is toll-free |
| `#premium?` | Whether the number is a premium-rate line |
| `#area_code_info` | Area code metadata `{ area_code:, region: }` for US/CA/GB/DE |
| `#similar_to?(other)` | Whether two numbers have the same E.164 representation |
| `#eql?(other)` / `#hash` | E.164-keyed equality + hash, so numbers dedupe in a `Set` / collapse as `Hash` keys |
| `#country_name` | Human-readable country name (e.g. "United States") |
| `#carrier` | Carrier name based on prefix (US, CA, GB, DE) |
| `#masked(visible:)` | E.164 form with national digits masked as `*` except the last `visible` (default 4) |
| `#to_h` | Hash representation with all phone number attributes |
| `#inspect` | Human-readable debug string |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## Support

If you find this project useful:

⭐ [Star the repo](https://github.com/philiprehberger/rb-phone)

🐛 [Report issues](https://github.com/philiprehberger/rb-phone/issues?q=is%3Aissue+is%3Aopen+label%3Abug)

💡 [Suggest features](https://github.com/philiprehberger/rb-phone/issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)

❤️ [Sponsor development](https://github.com/sponsors/philiprehberger)

🌐 [All Open Source Projects](https://philiprehberger.com/open-source-packages)

💻 [GitHub Profile](https://github.com/philiprehberger)

🔗 [LinkedIn Profile](https://www.linkedin.com/in/philiprehberger)

## License

[MIT](LICENSE)
