# frozen_string_literal: true

module Philiprehberger
  module Phone
    # SMS shortcode validation rules per country
    SHORTCODE_RULES = {
      us: { lengths: [5, 6] },
      ca: { lengths: [5, 6] },
      gb: { lengths: [5, 6] },
      de: { lengths: [4, 5] },
      fr: { lengths: [5] },
      au: { lengths: [6] },
      in: { lengths: [5, 6] }
    }.freeze

    module ShortcodeValidation
      def self.valid_shortcode?(input, country: :us)
        digits = input.to_s.gsub(/\D/, '')
        return false if digits.empty?

        rules = SHORTCODE_RULES[country]
        return false unless rules

        rules[:lengths].include?(digits.length)
      end
    end
  end
end
