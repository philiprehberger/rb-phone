# Changelog

All notable changes to this gem will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2026-03-21

### Added
- Initial release
- Phone number parsing from various string formats
- E.164, national, and international formatting
- Country detection from leading digits
- Country hint for parsing numbers without country code
- Validation against country-specific length rules
- Support for 30+ countries (US, GB, DE, FR, JP, AU, and more)
- Immutable `Number` value object with equality comparison
