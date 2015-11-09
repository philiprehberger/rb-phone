# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
n## [0.1.1] - 2026-03-22

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

[Unreleased]: https://github.com/philiprehberger/rb-phone/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/philiprehberger/rb-phone/releases/tag/v0.1.0
