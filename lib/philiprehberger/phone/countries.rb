# frozen_string_literal: true

module Philiprehberger
  module Phone
    COUNTRIES = {
      us: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'United States' },
      ca: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'Canada' },
      gb: { code: '44', lengths: [10, 11], format: '%s %s %s', groups: [4, 3, 4], name: 'United Kingdom' },
      de: { code: '49', lengths: [10, 11], format: '%s %s %s', groups: [3, 4, 4], name: 'Germany' },
      fr: { code: '33', lengths: [9], format: '%s %s %s %s %s', groups: [1, 2, 2, 2, 2], name: 'France' },
      it: { code: '39', lengths: [9, 10], format: '%s %s %s', groups: [3, 3, 4], name: 'Italy' },
      es: { code: '34', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Spain' },
      pt: { code: '351', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Portugal' },
      nl: { code: '31', lengths: [9], format: '%s %s %s', groups: [2, 3, 4], name: 'Netherlands' },
      be: { code: '32', lengths: [8, 9], format: '%s %s %s', groups: [3, 3, 3], name: 'Belgium' },
      at: { code: '43', lengths: [10, 11], format: '%s %s %s', groups: [3, 4, 4], name: 'Austria' },
      ch: { code: '41', lengths: [9], format: '%s %s %s %s', groups: [2, 3, 2, 2], name: 'Switzerland' },
      se: { code: '46', lengths: [9, 10], format: '%s %s %s', groups: [3, 3, 4], name: 'Sweden' },
      no: { code: '47', lengths: [8], format: '%s %s %s', groups: [3, 2, 3], name: 'Norway' },
      dk: { code: '45', lengths: [8], format: '%s %s %s %s', groups: [2, 2, 2, 2], name: 'Denmark' },
      fi: { code: '358', lengths: [9, 10], format: '%s %s %s', groups: [3, 3, 4], name: 'Finland' },
      pl: { code: '48', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Poland' },
      au: { code: '61', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Australia' },
      nz: { code: '64', lengths: [8, 9], format: '%s %s %s', groups: [3, 3, 3], name: 'New Zealand' },
      jp: { code: '81', lengths: [10, 11], format: '%s-%s-%s', groups: [3, 4, 4], name: 'Japan' },
      cn: { code: '86', lengths: [11], format: '%s %s %s', groups: [3, 4, 4], name: 'China' },
      in: { code: '91', lengths: [10], format: '%s %s %s', groups: [4, 3, 3], name: 'India' },
      br: { code: '55', lengths: [10, 11], format: '(%s) %s-%s', groups: [2, 4, 4], name: 'Brazil' },
      mx: { code: '52', lengths: [10], format: '%s %s %s', groups: [3, 3, 4], name: 'Mexico' },
      ar: { code: '54', lengths: [10], format: '%s %s %s', groups: [3, 3, 4], name: 'Argentina' },
      za: { code: '27', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'South Africa' },
      kr: { code: '82', lengths: [9, 10], format: '%s-%s-%s', groups: [3, 3, 4], name: 'South Korea' },
      sg: { code: '65', lengths: [8], format: '%s %s', groups: [4, 4], name: 'Singapore' },
      hk: { code: '852', lengths: [8], format: '%s %s', groups: [4, 4], name: 'Hong Kong' },
      ie: { code: '353', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Ireland' },
      il: { code: '972', lengths: [9], format: '%s-%s-%s', groups: [2, 3, 4], name: 'Israel' },
      ru: { code: '7', lengths: [10], format: '(%s) %s-%s-%s', groups: [3, 3, 2, 2], name: 'Russia' },
    }.freeze

    COUNTRY_CODE_MAP = COUNTRIES.each_with_object({}) do |(sym, data), map|
      map[data[:code]] ||= []
      map[data[:code]] << sym
    end.freeze
  end
end
