# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this gem adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.1] - 2026-03-31

### Changed
- Standardize README badges, support section, and license format

## [0.4.0] - 2026-03-29

### Added
- `#to_h` method on `PhoneNumber` for hash serialization
- `#inspect` method on `PhoneNumber` for human-readable debug output
- Phone type detection patterns for 21 additional countries (now covers all 36)

### Fixed
- Gemspec authors, email, ruby version, and file glob to match template guide
- README badges, usage section, and support section to match template guide
- Add missing `.github/` files (issue templates, dependabot, PR template)

## [0.3.0] - 2026-03-28

### Added
- Expand country support from 9 to 36 countries (MX, ES, IT, NL, BE, CH, AT, SE, NO, DK, FI, PL, PT, IE, RU, CN, KR, SG, NZ, ZA, NG, KE, EG, AR, CL, CO, PE)
- Phone type detection (`#phone_type`) returns :mobile, :landline, :toll_free, :premium, or :unknown based on prefix patterns
- Area code metadata lookup (`#area_code_info`) returns region/city for US, CA, GB, and DE area codes
- Vanity number conversion (`.vanity_to_digits`) converts letters to digits (e.g. "1-800-FLOWERS")
- SMS shortcode validation (`.valid_shortcode?`) for US, CA, GB, DE, FR, AU, and IN
- Carrier identification (`#carrier`) for major US carriers (AT&T, Verizon, T-Mobile)

## [0.2.0] - 2026-03-26

### Fixed
- Add Sponsor badge to README
- Fix license section link format

## [0.1.9] - 2026-03-24

### Fixed
- Fix stray character in CHANGELOG formatting

## [0.1.8] - 2026-03-24

### Fixed
- Standardize README code examples to use double-quote require statements

## [0.1.7] - 2026-03-24

### Fixed
- Fix Installation section quote style to double quotes

## [0.1.6] - 2026-03-23

### Fixed
- Standardize README to match template guide

## [0.1.5] - 2026-03-22

### Changed
- Expand test coverage with edge cases, additional country formats, and error paths

## [0.1.4] - 2026-03-22

### Changed
- Fix README badges to match template (Tests, Gem Version, License)

## [0.1.3] - 2026-03-22

### Changed
- Add License badge to README

## [0.1.2] - 2026-03-22

### Fixed

- Fix CHANGELOG header wording
- Add bug_tracker_uri to gemspec

## [0.1.1] - 2026-03-22

### Changed
- Improve source code, tests, and rubocop compliance

## [0.1.0] - 2026-03-22

### Added

- Initial release
- Phone number parsing from various string formats
- E.164, national, and international formatting
- Country detection from leading country code digits
- Country hint for parsing numbers without country code
- Validation against country-specific length rules
- Support for US, CA, GB, DE, FR, AU, JP, IN, BR
- Immutable `PhoneNumber` value object with equality comparison

[Unreleased]: https://github.com/philiprehberger/rb-phone/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/philiprehberger/rb-phone/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/philiprehberger/rb-phone/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/philiprehberger/rb-phone/compare/v0.1.9...v0.2.0
[0.1.9]: https://github.com/philiprehberger/rb-phone/compare/v0.1.8...v0.1.9
[0.1.8]: https://github.com/philiprehberger/rb-phone/compare/v0.1.7...v0.1.8
[0.1.7]: https://github.com/philiprehberger/rb-phone/compare/v0.1.6...v0.1.7
[0.1.6]: https://github.com/philiprehberger/rb-phone/compare/v0.1.5...v0.1.6
[0.1.5]: https://github.com/philiprehberger/rb-phone/compare/v0.1.4...v0.1.5
[0.1.4]: https://github.com/philiprehberger/rb-phone/compare/v0.1.3...v0.1.4
[0.1.3]: https://github.com/philiprehberger/rb-phone/compare/v0.1.2...v0.1.3
[0.1.2]: https://github.com/philiprehberger/rb-phone/compare/v0.1.1...v0.1.2
[0.1.1]: https://github.com/philiprehberger/rb-phone/compare/v0.1.0...v0.1.1
[0.1.0]: https://github.com/philiprehberger/rb-phone/releases/tag/v0.1.0
