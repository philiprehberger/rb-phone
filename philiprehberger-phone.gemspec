# frozen_string_literal: true

require_relative 'lib/philiprehberger/phone/version'

Gem::Specification.new do |spec|
  spec.name = 'philiprehberger-phone'
  spec.version = Philiprehberger::Phone::VERSION
  spec.authors = ['philiprehberger']
  spec.email = ['philiprehberger@users.noreply.github.com']

  spec.summary = 'Lightweight phone number parsing, validation, and formatting'
  spec.description = 'Parse phone numbers from various formats, validate against country rules, ' \
                     'and format as E.164, national, or international. Supports US, GB, DE, FR, ' \
                     'AU, JP, IN, BR, and more without external dependencies.'
  spec.homepage = 'https://github.com/philiprehberger/rb-phone'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['lib/**/*', 'LICENSE', 'README.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']
end
