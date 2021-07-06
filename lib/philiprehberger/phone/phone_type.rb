# frozen_string_literal: true

module Philiprehberger
  module Phone
    # Phone type detection based on prefix patterns per country
    PHONE_TYPE_PATTERNS = {
      us: {
        toll_free: /\A(800|888|877|866|855|844|833)\d{7}\z/,
        premium: /\A(900|976)\d{7}\z/,
        mobile: /\A[2-9]\d{2}[2-9]\d{6}\z/
      },
      ca: {
        toll_free: /\A(800|888|877|866|855|844|833)\d{7}\z/,
        premium: /\A(900|976)\d{7}\z/,
        mobile: /\A[2-9]\d{2}[2-9]\d{6}\z/
      },
      gb: {
        toll_free: /\A(800|808)\d{6,7}\z/,
        premium: /\A(90[0-9]|91[0-9])\d{7}\z/,
        mobile: /\A7[1-9]\d{8}\z/,
        landline: /\A(1|2)\d{8,9}\z/
      },
      de: {
        toll_free: /\A800\d{7}\z/,
        premium: /\A(900|906)\d{6,7}\z/,
        mobile: /\A(15|16|17)\d{8,9}\z/,
        landline: /\A(2|3|4|5|6|7|8|9)\d{8,9}\z/
      },
      fr: {
        toll_free: /\A800\d{6}\z/,
        premium: /\A8[1-9]\d{7}\z/,
        mobile: /\A[67]\d{8}\z/,
        landline: /\A[1-5]\d{8}\z/
      },
      au: {
        toll_free: /\A(1800)\d{6}\z/,
        premium: /\A(190[0-9])\d{6}\z/,
        mobile: /\A4\d{8}\z/,
        landline: /\A[2378]\d{8}\z/
      },
      jp: {
        toll_free: /\A(120|800)\d{7}\z/,
        mobile: /\A[789]0\d{8}\z/,
        landline: /\A[1-6]\d{8,9}\z/
      },
      in: {
        toll_free: /\A(1800)\d{6,7}\z/,
        mobile: /\A[6-9]\d{9}\z/,
        landline: /\A[1-5]\d{9}\z/
      },
      br: {
        toll_free: /\A(0800)\d{7}\z/,
        mobile: /\A\d{2}9\d{8}\z/,
        landline: /\A\d{2}[2-5]\d{7}\z/
      },
      mx: {
        mobile: /\A[1-9]\d{9}\z/
      },
      es: {
        toll_free: /\A(800|900)\d{6}\z/,
        mobile: /\A[67]\d{8}\z/,
        landline: /\A[89]\d{8}\z/
      },
      it: {
        toll_free: /\A800\d{6}\z/,
        mobile: /\A3\d{8,9}\z/,
        landline: /\A0\d{8,9}\z/
      },
      ru: {
        toll_free: /\A(800)\d{7}\z/,
        mobile: /\A9\d{9}\z/,
        landline: /\A[3-8]\d{9}\z/
      },
      cn: {
        mobile: /\A1[3-9]\d{9}\z/,
        landline: /\A[2-9]\d{9,10}\z/
      },
      kr: {
        toll_free: /\A(80)\d{7,8}\z/,
        mobile: /\A(10|11|16|17|18|19)\d{7,8}\z/,
        landline: /\A(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])\d{7,8}\z/
      }
    }.freeze

    module PhoneTypeDetection
      def phone_type
        return :unknown unless @country

        patterns = PHONE_TYPE_PATTERNS[@country]
        return :unknown unless patterns

        %i[toll_free premium mobile landline].each do |type|
          pattern = patterns[type]
          return type if pattern&.match?(@national)
        end

        :unknown
      end
    end
  end
end
