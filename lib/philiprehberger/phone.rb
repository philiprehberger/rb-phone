# frozen_string_literal: true

require_relative 'phone/version'
require_relative 'phone/countries'
require_relative 'phone/phone_type'
require_relative 'phone/area_code'
require_relative 'phone/vanity'
require_relative 'phone/shortcode'
require_relative 'phone/carrier'

module Philiprehberger
  module Phone
    class ParseError < StandardError; end

    class PhoneNumber
      include PhoneTypeDetection
      include AreaCodeLookup
      include CarrierLookup

      attr_reader :country_code, :national, :country

      def initialize(country_code:, national:, country:)
        @country_code = country_code
        @national = national
        @country = country
        freeze
      end

      def valid?
        return false unless @country

        data = COUNTRIES[@country]
        return false unless data

        data[:lengths].include?(@national.length)
      end

      def e164
        "+#{@country_code}#{@national}"
      end

      def formatted
        format_national
      end

      def international
        "+#{@country_code} #{format_national}"
      end

      def to_s
        e164
      end

      def ==(other)
        other.is_a?(PhoneNumber) && e164 == other.e164
      end

      def to_h
        {
          country_code: country_code,
          national: national,
          country: country,
          e164: e164,
          formatted: formatted,
          international: international,
          valid: valid?,
          phone_type: phone_type,
          area_code_info: area_code_info,
          carrier: carrier
        }
      end

      def inspect
        "#<Philiprehberger::Phone::PhoneNumber #{e164} (#{country || 'unknown'})>"
      end

      private

      def format_national
        data = COUNTRIES[@country]
        return @national unless data

        groups = data[:groups]
        digits = @national.dup
        parts = groups.map { |len| digits.slice!(0, len) }
        parts << digits unless digits.empty?
        parts.reject!(&:empty?)

        format(data[:format], *parts)
      rescue ArgumentError, TypeError
        @national
      end

      def format(pattern, *args)
        pattern % args
      end
    end

    def self.parse(input, country: nil)
      cleaned = input.to_s.strip
      return PhoneNumber.new(country_code: '', national: '', country: nil) if cleaned.empty?

      has_plus = cleaned.start_with?('+')
      digits = cleaned.gsub(/[^\d]/, '')

      if has_plus
        cc, national, sym = detect_country_from_digits(digits)
      elsif country
        data = COUNTRIES[country]
        raise ParseError, "unknown country: #{country}" unless data

        cc = data[:code]
        national = digits.delete_prefix(cc)
        sym = country
      else
        cc, national, sym = detect_country_from_digits(digits)
      end

      PhoneNumber.new(country_code: cc, national: national, country: sym)
    end

    def self.valid?(input, country: nil)
      parse(input, country: country).valid?
    rescue ParseError
      false
    end

    def self.vanity_to_digits(input)
      VanityConversion.vanity_to_digits(input)
    end

    def self.valid_shortcode?(input, country: :us)
      ShortcodeValidation.valid_shortcode?(input, country: country)
    end

    def self.detect_country_from_digits(digits)
      [3, 2, 1].each do |len|
        next if digits.length < len

        code = digits[0, len]
        next unless COUNTRY_CODE_MAP[code]

        sym = COUNTRY_CODE_MAP[code].first
        national = digits[len..]
        return [code, national, sym]
      end

      ['', digits, nil]
    end

    private_class_method :detect_country_from_digits
  end
end
