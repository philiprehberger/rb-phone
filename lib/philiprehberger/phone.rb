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

      # Whether the phone number matches the country length rules.
      #
      # @return [Boolean]
      def valid?
        return false unless @country

        data = COUNTRIES[@country]
        return false unless data

        data[:lengths].include?(@national.length)
      end

      # E.164-formatted phone number (e.g. "+15551234567").
      #
      # @return [String]
      def e164
        "+#{@country_code}#{@national}"
      end

      # National (country-specific) formatted representation.
      #
      # @return [String]
      def formatted
        format_national
      end

      # International formatted representation with country code prefix.
      #
      # @return [String]
      def international
        "+#{@country_code} #{format_national}"
      end

      # String representation (E.164).
      #
      # @return [String]
      def to_s
        e164
      end

      # E.164 form with national digits masked as `*` except the last
      # `visible` digits; country code remains visible.
      #
      # @param visible [Integer] number of trailing digits to keep visible
      # @return [String]
      def masked(visible: 4)
        digits = @national
        clamped = visible.clamp(0, digits.length)
        masked_count = digits.length - clamped
        "+#{@country_code}#{'*' * masked_count}#{digits[masked_count..]}"
      end

      # Equality based on E.164 representation.
      #
      # @param other [PhoneNumber] another phone number to compare
      # @return [Boolean]
      def ==(other)
        other.is_a?(PhoneNumber) && e164 == other.e164
      end

      # Hash-key equality based on E.164 representation, so equal numbers
      # collapse as Hash keys and dedupe in a Set.
      #
      # @param other [Object] another object to compare
      # @return [Boolean]
      def eql?(other)
        other.is_a?(PhoneNumber) && e164 == other.e164
      end

      # Hash code derived from the E.164 representation.
      #
      # @return [Integer]
      def hash
        e164.hash
      end

      def similar_to?(other)
        return false unless other.is_a?(PhoneNumber)

        e164 == other.e164
      end

      # Hash representation including all derived attributes.
      #
      # @return [Hash]
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

      # Human-readable country name (e.g. "United States").
      #
      # @return [String, nil]
      def country_name
        COUNTRIES.dig(@country, :name)
      end

      # Whether the number is a mobile line.
      #
      # @return [Boolean]
      def mobile?
        phone_type == :mobile
      end

      # Whether the number is a landline.
      #
      # @return [Boolean]
      def landline?
        phone_type == :landline
      end

      # Whether the number is toll-free.
      #
      # @return [Boolean]
      def toll_free?
        phone_type == :toll_free
      end

      # Whether the number is a premium-rate line.
      #
      # @return [Boolean]
      def premium?
        phone_type == :premium
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

        data[:format] % parts
      rescue ArgumentError, TypeError
        @national
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
        # Nationally-formatted input for trunk-prefix countries keeps a leading
        # `0` (e.g. GB "020 7946 0958"); strip it so the E.164 is well-formed.
        national = national.delete_prefix('0') if data[:trunk_prefix]
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

    # Return the detected country symbol for `input`, or `nil` if the
    # input cannot be associated with a known country. Never raises.
    #
    # @param input [String] phone number in any recognized form
    # @param country [Symbol, nil] optional country hint
    # @return [Symbol, nil]
    def self.country_of(input, country: nil)
      parse(input, country: country).country
    rescue ParseError
      nil
    end

    FORMATS = {
      e164: :e164,
      national: :formatted,
      international: :international
    }.freeze

    # Parse and format an input in one call.
    #
    # @param input [String] phone number in any recognized form
    # @param format [Symbol] `:e164`, `:national`, or `:international`
    # @param country [Symbol, nil] country hint for parsing
    # @return [String] formatted phone number
    # @raise [ArgumentError] for unknown format symbols
    # @raise [ParseError] when the input cannot be parsed
    def self.format(input, format:, country: nil)
      method_name = FORMATS[format] or
        raise ArgumentError, "Unknown format: #{format.inspect} (expected :e164, :national, or :international)"

      parse(input, country: country).public_send(method_name)
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
        # NANP (+1) is shared by the US and Canada; disambiguate by the
        # 3-digit area code so CA numbers get the right area-code/carrier data.
        sym = :ca if code == '1' && AREA_CODES[:ca].key?(national[0, 3])
        return [code, national, sym]
      end

      ['', digits, nil]
    end

    private_class_method :detect_country_from_digits
  end
end
