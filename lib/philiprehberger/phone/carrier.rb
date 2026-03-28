# frozen_string_literal: true

module Philiprehberger
  module Phone
    # Carrier identification based on NPA-NXX prefix ranges (US only for now)
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
      }
    }.freeze

    module CarrierLookup
      def carrier
        return nil unless @country

        prefixes = CARRIER_PREFIXES[@country]
        return nil unless prefixes

        npa = @national[0, 3]
        return nil unless npa && npa.length == 3

        prefixes.each do |carrier_name, npa_list|
          return carrier_name if npa_list.include?(npa)
        end

        nil
      end
    end
  end
end
