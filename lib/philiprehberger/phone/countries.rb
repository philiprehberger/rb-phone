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
      br: { code: '55', lengths: [10, 11], format: '(%s) %s-%s', groups: [2, 5, 4], name: 'Brazil' },
      mx: { code: '52', lengths: [10], format: '%s %s %s', groups: [3, 3, 4], name: 'Mexico' },
      es: { code: '34', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Spain' },
      it: { code: '39', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Italy' },
      nl: { code: '31', lengths: [9], format: '%s %s', groups: [3, 6], name: 'Netherlands' },
      be: { code: '32', lengths: [8, 9], format: '%s %s %s', groups: [3, 3, 3], name: 'Belgium' },
      ch: { code: '41', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Switzerland' },
      at: { code: '43', lengths: [10, 11], format: '%s %s', groups: [4, 7], name: 'Austria' },
      se: { code: '46', lengths: [9, 10], format: '%s-%s %s', groups: [3, 3, 4], name: 'Sweden' },
      no: { code: '47', lengths: [8], format: '%s %s %s', groups: [3, 2, 3], name: 'Norway' },
      dk: { code: '45', lengths: [8], format: '%s %s %s %s', groups: [2, 2, 2, 2], name: 'Denmark' },
      fi: { code: '358', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Finland' },
      pl: { code: '48', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Poland' },
      pt: { code: '351', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Portugal' },
      ie: { code: '353', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Ireland' },
      ru: { code: '7', lengths: [10], format: '(%s) %s-%s-%s', groups: [3, 3, 2, 2], name: 'Russia' },
      cn: { code: '86', lengths: [11], format: '%s %s %s', groups: [3, 4, 4], name: 'China' },
      kr: { code: '82', lengths: [10, 11], format: '%s-%s-%s', groups: [3, 4, 4], name: 'South Korea' },
      sg: { code: '65', lengths: [8], format: '%s %s', groups: [4, 4], name: 'Singapore' },
      nz: { code: '64', lengths: [8, 9, 10], format: '%s %s', groups: [3, 7], name: 'New Zealand' },
      za: { code: '27', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'South Africa' },
      ng: { code: '234', lengths: [10, 11], format: '%s %s %s', groups: [3, 4, 4], name: 'Nigeria' },
      ke: { code: '254', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Kenya' },
      eg: { code: '20', lengths: [10], format: '%s %s %s', groups: [3, 4, 3], name: 'Egypt' },
      ar: { code: '54', lengths: [10], format: '%s %s-%s', groups: [3, 3, 4], name: 'Argentina' },
      cl: { code: '56', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Chile' },
      co: { code: '57', lengths: [10], format: '%s %s %s', groups: [3, 3, 4], name: 'Colombia' },
      pe: { code: '51', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Peru' }
    }.freeze

    COUNTRY_CODE_MAP = COUNTRIES.each_with_object({}) do |(sym, data), map|
      map[data[:code]] ||= []
      map[data[:code]] << sym
    end.freeze
  end
end
