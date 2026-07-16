# frozen_string_literal: true

module Philiprehberger
  module Phone
    # `trunk_prefix: true` marks countries that use a national trunk `0`
    # (dropped when composing E.164). It is intentionally absent for NANP
    # (`+1`) and for numbering plans where a leading `0` is significant
    # (e.g. Italy, South Africa).
    COUNTRIES = {
      us: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'United States' },
      ca: { code: '1', lengths: [10], format: '(%s) %s-%s', groups: [3, 3, 4], name: 'Canada' },
      gb: { code: '44', lengths: [10, 11], format: '%s %s', groups: [4, 6], name: 'United Kingdom', trunk_prefix: true },
      de: { code: '49', lengths: [10, 11], format: '%s %s', groups: [4, 7], name: 'Germany', trunk_prefix: true },
      fr: { code: '33', lengths: [9], format: '%s %s %s %s %s', groups: [1, 2, 2, 2, 2], name: 'France', trunk_prefix: true },
      au: { code: '61', lengths: [9], format: '%s %s %s', groups: [4, 3, 3], name: 'Australia', trunk_prefix: true },
      jp: { code: '81', lengths: [10, 11], format: '%s-%s-%s', groups: [2, 4, 4], name: 'Japan', trunk_prefix: true },
      in: { code: '91', lengths: [10], format: '%s %s', groups: [5, 5], name: 'India', trunk_prefix: true },
      br: { code: '55', lengths: [10, 11], format: '(%s) %s-%s', groups: [2, 5, 4], name: 'Brazil' },
      mx: { code: '52', lengths: [10], format: '%s %s %s', groups: [3, 3, 4], name: 'Mexico' },
      es: { code: '34', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Spain' },
      it: { code: '39', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Italy' },
      nl: { code: '31', lengths: [9], format: '%s %s', groups: [3, 6], name: 'Netherlands', trunk_prefix: true },
      be: { code: '32', lengths: [8, 9], format: '%s %s %s', groups: [3, 3, 3], name: 'Belgium', trunk_prefix: true },
      ch: { code: '41', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Switzerland', trunk_prefix: true },
      at: { code: '43', lengths: [10, 11], format: '%s %s', groups: [4, 7], name: 'Austria', trunk_prefix: true },
      se: { code: '46', lengths: [9, 10], format: '%s-%s %s', groups: [3, 3, 4], name: 'Sweden', trunk_prefix: true },
      no: { code: '47', lengths: [8], format: '%s %s %s', groups: [3, 2, 3], name: 'Norway' },
      dk: { code: '45', lengths: [8], format: '%s %s %s %s', groups: [2, 2, 2, 2], name: 'Denmark' },
      fi: { code: '358', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Finland', trunk_prefix: true },
      pl: { code: '48', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Poland' },
      pt: { code: '351', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'Portugal' },
      ie: { code: '353', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Ireland', trunk_prefix: true },
      ru: { code: '7', lengths: [10], format: '(%s) %s-%s-%s', groups: [3, 3, 2, 2], name: 'Russia' },
      cn: { code: '86', lengths: [11], format: '%s %s %s', groups: [3, 4, 4], name: 'China', trunk_prefix: true },
      kr: { code: '82', lengths: [10, 11], format: '%s-%s-%s', groups: [3, 4, 4], name: 'South Korea', trunk_prefix: true },
      sg: { code: '65', lengths: [8], format: '%s %s', groups: [4, 4], name: 'Singapore' },
      nz: { code: '64', lengths: [8, 9, 10], format: '%s %s', groups: [3, 7], name: 'New Zealand', trunk_prefix: true },
      za: { code: '27', lengths: [9], format: '%s %s %s', groups: [3, 3, 3], name: 'South Africa' },
      ng: { code: '234', lengths: [10, 11], format: '%s %s %s', groups: [3, 4, 4], name: 'Nigeria', trunk_prefix: true },
      ke: { code: '254', lengths: [9, 10], format: '%s %s', groups: [3, 7], name: 'Kenya', trunk_prefix: true },
      eg: { code: '20', lengths: [10], format: '%s %s %s', groups: [3, 4, 3], name: 'Egypt', trunk_prefix: true },
      ar: { code: '54', lengths: [10], format: '%s %s-%s', groups: [3, 3, 4], name: 'Argentina', trunk_prefix: true },
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
