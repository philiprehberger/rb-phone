# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Philiprehberger::Phone do
  it 'has a version number' do
    expect(Philiprehberger::Phone::VERSION).not_to be_nil
  end

  describe '.parse' do
    context 'with US numbers' do
      it 'parses "+1 (555) 123-4567" to e164 "+15551234567" and country :us' do
        phone = described_class.parse('+1 (555) 123-4567')
        expect(phone.e164).to eq('+15551234567')
        expect(phone.country).to eq(:us)
      end

      it 'parses E.164 format' do
        phone = described_class.parse('+15551234567')
        expect(phone.country_code).to eq('1')
        expect(phone.national).to eq('5551234567')
        expect(phone.country).to eq(:us)
      end

      it 'formats US number correctly' do
        phone = described_class.parse('+15551234567')
        expect(phone.formatted).to eq('(555) 123-4567')
      end

      it 'formats international correctly' do
        phone = described_class.parse('+15551234567')
        expect(phone.international).to eq('+1 (555) 123-4567')
      end
    end

    context 'with UK numbers' do
      it 'parses "+44 20 7946 0958" to e164 "+442079460958"' do
        phone = described_class.parse('+44 20 7946 0958')
        expect(phone.e164).to eq('+442079460958')
        expect(phone.country).to eq(:gb)
      end

      it 'parses with country hint "020 7946 0958" with country: :gb' do
        phone = described_class.parse('020 7946 0958', country: :gb)
        expect(phone.country_code).to eq('44')
        expect(phone.country).to eq(:gb)
      end
    end

    context 'with other countries' do
      it 'parses German number' do
        phone = described_class.parse('+4930123456789')
        expect(phone.country_code).to eq('49')
        expect(phone.country).to eq(:de)
      end

      it 'parses Japanese number' do
        phone = described_class.parse('+81312345678')
        expect(phone.country_code).to eq('81')
        expect(phone.country).to eq(:jp)
      end

      it 'parses French number' do
        phone = described_class.parse('+33612345678')
        expect(phone.country_code).to eq('33')
        expect(phone.country).to eq(:fr)
      end
    end
  end

  describe '.valid?' do
    it 'returns true for valid US number' do
      expect(described_class.valid?('+15551234567')).to be true
    end

    it 'returns false for too short number' do
      expect(described_class.valid?('+1555')).to be false
    end

    it 'returns false for too long number' do
      expect(described_class.valid?('+155512345678900')).to be false
    end

    it 'returns false for letters' do
      expect(described_class.valid?('abc')).to be false
    end

    it 'returns false for empty string' do
      expect(described_class.valid?('')).to be false
    end
  end

  describe Philiprehberger::Phone::PhoneNumber do
    let(:us_number) { described_class.new(country_code: '1', national: '5551234567', country: :us) }

    describe '#valid?' do
      it 'returns true for valid number' do
        expect(us_number).to be_valid
      end

      it 'returns false for wrong length' do
        short = described_class.new(country_code: '1', national: '555', country: :us)
        expect(short).not_to be_valid
      end
    end

    describe '#e164' do
      it 'returns E.164 format' do
        expect(us_number.e164).to eq('+15551234567')
      end
    end

    describe '#country_code' do
      it 'returns the country calling code' do
        expect(us_number.country_code).to eq('1')
      end
    end

    describe '#national' do
      it 'returns digits only without country code' do
        expect(us_number.national).to eq('5551234567')
      end
    end

    describe '#country' do
      it 'returns the country symbol' do
        expect(us_number.country).to eq(:us)
      end
    end

    describe '#formatted' do
      it 'returns country-specific format for US' do
        expect(us_number.formatted).to eq('(555) 123-4567')
      end
    end

    describe '#international' do
      it 'returns international format' do
        expect(us_number.international).to eq('+1 (555) 123-4567')
      end
    end

    describe '#==' do
      it 'compares by E.164' do
        other = described_class.new(country_code: '1', national: '5551234567', country: :us)
        expect(us_number).to eq(other)
      end

      it 'is not equal for different numbers' do
        other = described_class.new(country_code: '1', national: '5559999999', country: :us)
        expect(us_number).not_to eq(other)
      end
    end

    describe '#to_s' do
      it 'returns E.164 string' do
        expect(us_number.to_s).to eq('+15551234567')
      end
    end

    describe '#valid? with nil country' do
      it 'returns false when country is nil' do
        phone = described_class.new(country_code: '1', national: '5551234567', country: nil)
        expect(phone).not_to be_valid
      end
    end

    describe '#valid? with unknown country symbol' do
      it 'returns false for unrecognized country' do
        phone = described_class.new(country_code: '99', national: '12345', country: :zz)
        expect(phone).not_to be_valid
      end
    end

    describe '#formatted with unknown country' do
      it 'returns raw national digits when country has no format data' do
        phone = described_class.new(country_code: '99', national: '12345', country: nil)
        expect(phone.formatted).to eq('12345')
      end
    end

    describe '#international with unknown country' do
      it 'returns +code digits when no format data exists' do
        phone = described_class.new(country_code: '99', national: '12345', country: nil)
        expect(phone.international).to eq('+99 12345')
      end
    end

    describe '#==' do
      it 'returns false when compared with non-PhoneNumber' do
        expect(us_number == '+15551234567').to be false
      end
    end

    describe 'frozen state' do
      it 'is frozen after initialization' do
        expect(us_number).to be_frozen
      end
    end
  end

  describe '.parse' do
    context 'with German numbers' do
      it 'formats German number correctly' do
        phone = described_class.parse('+4930123456789')
        expect(phone.formatted).to be_a(String)
        expect(phone.country).to eq(:de)
      end

      it 'parses German number with country hint' do
        phone = described_class.parse('030123456789', country: :de)
        expect(phone.country_code).to eq('49')
        expect(phone.country).to eq(:de)
      end
    end

    context 'with French numbers' do
      it 'formats French number correctly' do
        phone = described_class.parse('+33612345678')
        expect(phone.formatted).to be_a(String)
        expect(phone.country).to eq(:fr)
      end

      it 'validates French number length' do
        phone = described_class.parse('+33612345678')
        expect(phone.national.length).to eq(9)
        expect(phone).to be_valid
      end
    end

    context 'with Australian numbers' do
      it 'parses Australian number' do
        phone = described_class.parse('+61412345678')
        expect(phone.country_code).to eq('61')
        expect(phone.country).to eq(:au)
      end

      it 'formats Australian number' do
        phone = described_class.parse('+61412345678')
        expect(phone.formatted).to be_a(String)
      end

      it 'validates Australian number length' do
        phone = described_class.parse('+61412345678')
        expect(phone.national.length).to eq(9)
        expect(phone).to be_valid
      end
    end

    context 'with Japanese numbers' do
      it 'formats Japanese number with dashes' do
        phone = described_class.parse('+81312345678')
        expect(phone.formatted).to include('-')
      end

      it 'validates Japanese number' do
        phone = described_class.parse('+813123456789')
        expect(phone).to be_valid
      end
    end

    context 'with Indian numbers' do
      it 'parses Indian number' do
        phone = described_class.parse('+919876543210')
        expect(phone.country_code).to eq('91')
        expect(phone.country).to eq(:in)
      end
    end

    context 'with Brazilian numbers' do
      it 'parses Brazilian number' do
        phone = described_class.parse('+5511987654321')
        expect(phone.country_code).to eq('55')
        expect(phone.country).to eq(:br)
      end
    end

    context 'with invalid country code hint' do
      it 'raises ParseError for unknown country' do
        expect { described_class.parse('12345', country: :zz) }.to raise_error(Philiprehberger::Phone::ParseError)
      end
    end

    context 'with various input formats' do
      it 'strips whitespace from input' do
        phone = described_class.parse('  +15551234567  ')
        expect(phone.e164).to eq('+15551234567')
      end

      it 'handles dashes in number' do
        phone = described_class.parse('+1-555-123-4567')
        expect(phone.e164).to eq('+15551234567')
      end

      it 'handles dots in number' do
        phone = described_class.parse('+1.555.123.4567')
        expect(phone.e164).to eq('+15551234567')
      end

      it 'handles spaces in number' do
        phone = described_class.parse('+1 555 123 4567')
        expect(phone.e164).to eq('+15551234567')
      end

      it 'returns empty PhoneNumber for empty input' do
        phone = described_class.parse('')
        expect(phone.country_code).to eq('')
        expect(phone.national).to eq('')
        expect(phone.country).to be_nil
      end

      it 'returns empty PhoneNumber for whitespace-only input' do
        phone = described_class.parse('   ')
        expect(phone.country_code).to eq('')
        expect(phone.national).to eq('')
      end

      it 'handles very long digit strings' do
        phone = described_class.parse("+1#{'5' * 30}")
        expect(phone.country_code).to eq('1')
        expect(phone).not_to be_valid
      end

      it 'handles number with no plus and no country hint' do
        phone = described_class.parse('15551234567')
        expect(phone.country_code).to eq('1')
      end
    end
  end

  describe '.valid?' do
    it 'returns true for valid UK number' do
      expect(described_class.valid?('+442079460958')).to be true
    end

    it 'returns true for valid French number' do
      expect(described_class.valid?('+33612345678')).to be true
    end

    it 'returns false for unknown country code hint' do
      expect(described_class.valid?('12345', country: :zz)).to be false
    end
  end
end
