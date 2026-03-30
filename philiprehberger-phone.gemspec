# frozen_string_literal: true

require_relative 'lib/philiprehberger/phone/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-phone'
  spec.version = Philiprehberger::Phone::VERSION
  spec.authors = ['Philip Rehberger']
  spec.email = ['me@philiprehberger.com']

  spec.summary = 'Lightweight phone number parsing, validation, formatting, and metadata lookup for 36 countries'
  spec.description = 'Parse phone numbers from various formats, validate against country rules, ' \
                     'and format as E.164, national, or international. Supports 36 countries with ' \
                     'phone type detection, area code lookup, vanity number conversion, SMS shortcode ' \
                     'validation, and carrier identification — all without external dependencies.'
  spec.homepage = 'https://github.com/philiprehberger/rb-phone'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['bug_tracker_uri'] = "#{spec.homepage}/issues"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*.rb', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
