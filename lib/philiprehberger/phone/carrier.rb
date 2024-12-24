# frozen_string_literal: true

module Philiprehberger
  module Phone
    # Carrier identification based on prefix ranges
    # These are representative ranges; real carrier data changes frequently
    CARRIER_PREFIXES = {
      us: {
        'AT&T' => %w[
          200 201 202 203 205 206 207 208 209 210
          212 213 214 215 217 219 224 225 228 229
          231 234 239 240 248 251 252 253 254 256
          260 262 267 269 270 276 278 281
        ],
        'Verizon' => %w[
          301 302 303 304 305 307 308 310 312 313
          314 315 316 317 318 319 320 321 323 325
          330 331 334 336 337 339 340 346 347 351
          352 360 361 364 380 385 386
        ],
        'T-Mobile' => %w[
          401 402 404 405 406 407 408 409 410 412
          413 414 415 417 419 423 424 425 430 432
          434 435 440 442 443 445 447 458 463 469
          470 475 478 479 480 484
        ]
      },
      ca: {
        'Rogers' => %w[416 647 437],
        'Bell' => %w[613 514 819],
        'Telus' => %w[604 778 250],
        'Freedom' => %w[343 365]
      },
      gb: {
        'EE' => %w[74],
        'Three' => %w[73],
        'Vodafone' => %w[77],
        'O2' => %w[75]
      },
      de: {
        'Telekom' => %w[151 160 170 171],
        'Vodafone' => %w[152 162 172 173],
        'O2' => %w[155 157 163 176 177 178 179]
      }
    }.freeze

    module CarrierLookup
      def carrier
        return nil unless @country

        prefixes = CARRIER_PREFIXES[@country]
        return nil unless prefixes

        prefix = carrier_prefix_for_country
        return nil unless prefix

        prefixes.each do |carrier_name, prefix_list|
          return carrier_name if prefix_list.include?(prefix)
        end

        nil
      end

      private

      def carrier_prefix_for_country
        case @country
        when :us, :ca
          npa = @national[0, 3]
          npa && npa.length == 3 ? npa : nil
        when :gb
          prefix = @national[0, 2]
          prefix && prefix.length == 2 ? prefix : nil
        when :de
          prefix3 = @national[0, 3]
          return prefix3 if prefix3 && prefix3.length == 3 && CARRIER_PREFIXES[:de].any? { |_, list| list.include?(prefix3) }

          nil
        end
      end
    end
  end
end
