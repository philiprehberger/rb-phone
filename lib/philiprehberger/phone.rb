# frozen_string_literal: true

require_relative 'phone/version'
require_relative 'phone/countries'

module Philiprehberger
  module Phone
    class ParseError < StandardError; end

    class Number
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

      def format(style = :national)
        case style
        when :e164
          e164
        when :international
          "+#{@country_code} #{format_national}"
        when :national
          format_national
        else
          format_national
        end
      end

      def formatted
        format(:national)
      end

      def international
        format(:international)
      end

      def type
        :unknown
      end

      def to_s
        e164
      end

      def ==(other)
        other.is_a?(Number) && e164 == other.e164
      end

      private

      def format_national
        data = COUNTRIES[@country]
        return @national unless data

        groups = data[:groups]
        digits = @national.dup
        parts = groups.map do |len|
          part = digits.slice!(0, len)
          part
        end
        parts << digits unless digits.empty?

        sprintf(data[:format], *parts)
      rescue ArgumentError
        @national
      end
    end

    def self.parse(number, country: nil)
      digits = number.to_s.gsub(/[^\d+]/, '')
      has_plus = digits.start_with?('+')
      digits = digits.delete('+')

      if has_plus || country.nil?
        cc, national, sym = detect_country(digits, country)
      else
        data = COUNTRIES[country]
        raise ParseError, "unknown country: #{country}" unless data

        cc = data[:code]
        national = digits.delete_prefix(cc)
        national = digits if national == digits && !digits.start_with?(cc)
        sym = country
      end

      Number.new(country_code: cc, national: national, country: sym)
    end

    def self.valid?(number, country: nil)
      parse(number, country: country).valid?
    rescue ParseError
      false
    end

    def self.detect_country(digits, hint = nil)
      if hint
        data = COUNTRIES[hint]
        if data
          national = digits.delete_prefix(data[:code])
          return [data[:code], national, hint]
        end
      end

      [3, 2, 1].each do |len|
        code = digits[0, len]
        next unless COUNTRY_CODE_MAP[code]

        sym = COUNTRY_CODE_MAP[code].first
        national = digits[len..]
        return [code, national, sym]
      end

      [digits[0, 1], digits[1..], nil]
    end

    private_class_method :detect_country
  end
end
