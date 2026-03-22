# frozen_string_literal: true

module Philiprehberger
  module Phone
    COUNTRIES = {
      us: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'United States' },
      ca: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'Canada' },
      gb: { code: '44', lengths: [10, 11], format: '%s %s', groups: [4, 6], name: 'United Kingdom' },
      de: { code: '49', lengths: [10, 11], format: '%s %s', groups: [4, 7], name: 'Germany' },
      fr: { code: '33', lengths: [9], format: '%s %s %s %s %s', groups: [1, 2, 2, 2, 2], name: 'France' },
      au: { code: '61', lengths: [9], format: '%s %s %s', groups: [4, 3, 3], name: 'Australia' },
      jp: { code: '81', lengths: [10, 11], format: '%s-%s-%s', groups: [2, 4, 4], name: 'Japan' },
      in: { code: '91', lengths: [10], format: '%s %s', groups: [5, 5], name: 'India' },
      br: { code: '55', lengths: [10, 11], format: '(%s) %s-%s', groups: [2, 5, 4], name: 'Brazil' }
    }.freeze

    COUNTRY_CODE_MAP = COUNTRIES.each_with_object({}) do |(sym, data), map|
      map[data[:code]] ||= []
      map[data[:code]] << sym
    end.freeze
  end
end
