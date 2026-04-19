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

    context 'with newly added countries' do
      it 'parses Mexican number' do
        phone = described_class.parse('+525512345678')
        expect(phone.country_code).to eq('52')
        expect(phone.country).to eq(:mx)
      end

      it 'parses Spanish number' do
        phone = described_class.parse('+34612345678')
        expect(phone.country_code).to eq('34')
        expect(phone.country).to eq(:es)
      end

      it 'parses Italian number' do
        phone = described_class.parse('+393123456789')
        expect(phone.country_code).to eq('39')
        expect(phone.country).to eq(:it)
      end

      it 'parses Dutch number' do
        phone = described_class.parse('+31612345678')
        expect(phone.country_code).to eq('31')
        expect(phone.country).to eq(:nl)
      end

      it 'parses Belgian number' do
        phone = described_class.parse('+32412345678')
        expect(phone.country_code).to eq('32')
        expect(phone.country).to eq(:be)
      end

      it 'parses Swiss number' do
        phone = described_class.parse('+41441234567')
        expect(phone.country_code).to eq('41')
        expect(phone.country).to eq(:ch)
      end

      it 'parses Austrian number' do
        phone = described_class.parse('+431234567890')
        expect(phone.country_code).to eq('43')
        expect(phone.country).to eq(:at)
      end

      it 'parses Swedish number' do
        phone = described_class.parse('+46701234567')
        expect(phone.country_code).to eq('46')
        expect(phone.country).to eq(:se)
      end

      it 'parses Norwegian number' do
        phone = described_class.parse('+4712345678')
        expect(phone.country_code).to eq('47')
        expect(phone.country).to eq(:no)
      end

      it 'parses Danish number' do
        phone = described_class.parse('+4512345678')
        expect(phone.country_code).to eq('45')
        expect(phone.country).to eq(:dk)
      end

      it 'parses Finnish number' do
        phone = described_class.parse('+358401234567')
        expect(phone.country_code).to eq('358')
        expect(phone.country).to eq(:fi)
      end

      it 'parses Polish number' do
        phone = described_class.parse('+48512345678')
        expect(phone.country_code).to eq('48')
        expect(phone.country).to eq(:pl)
      end

      it 'parses Portuguese number' do
        phone = described_class.parse('+351912345678')
        expect(phone.country_code).to eq('351')
        expect(phone.country).to eq(:pt)
      end

      it 'parses Irish number' do
        phone = described_class.parse('+353861234567')
        expect(phone.country_code).to eq('353')
        expect(phone.country).to eq(:ie)
      end

      it 'parses Russian number' do
        phone = described_class.parse('+79161234567')
        expect(phone.country_code).to eq('7')
        expect(phone.country).to eq(:ru)
      end

      it 'parses Chinese number' do
        phone = described_class.parse('+8613912345678')
        expect(phone.country_code).to eq('86')
        expect(phone.country).to eq(:cn)
      end

      it 'parses South Korean number' do
        phone = described_class.parse('+821012345678')
        expect(phone.country_code).to eq('82')
        expect(phone.country).to eq(:kr)
      end

      it 'parses Singaporean number' do
        phone = described_class.parse('+6591234567')
        expect(phone.country_code).to eq('65')
        expect(phone.country).to eq(:sg)
      end

      it 'parses New Zealand number' do
        phone = described_class.parse('+6421123456')
        expect(phone.country_code).to eq('64')
        expect(phone.country).to eq(:nz)
      end

      it 'parses South African number' do
        phone = described_class.parse('+27821234567')
        expect(phone.country_code).to eq('27')
        expect(phone.country).to eq(:za)
      end

      it 'parses Nigerian number' do
        phone = described_class.parse('+2348012345678')
        expect(phone.country_code).to eq('234')
        expect(phone.country).to eq(:ng)
      end

      it 'parses Kenyan number' do
        phone = described_class.parse('+254712345678')
        expect(phone.country_code).to eq('254')
        expect(phone.country).to eq(:ke)
      end

      it 'parses Egyptian number' do
        phone = described_class.parse('+201012345678')
        expect(phone.country_code).to eq('20')
        expect(phone.country).to eq(:eg)
      end

      it 'parses Argentinian number' do
        phone = described_class.parse('+541112345678')
        expect(phone.country_code).to eq('54')
        expect(phone.country).to eq(:ar)
      end

      it 'parses Chilean number' do
        phone = described_class.parse('+56912345678')
        expect(phone.country_code).to eq('56')
        expect(phone.country).to eq(:cl)
      end

      it 'parses Colombian number' do
        phone = described_class.parse('+573001234567')
        expect(phone.country_code).to eq('57')
        expect(phone.country).to eq(:co)
      end

      it 'parses Peruvian number' do
        phone = described_class.parse('+51912345678')
        expect(phone.country_code).to eq('51')
        expect(phone.country).to eq(:pe)
      end
    end

    context 'with newly added country validation' do
      it 'validates Mexican number length' do
        phone = described_class.parse('+525512345678')
        expect(phone).to be_valid
      end

      it 'validates Spanish number length' do
        phone = described_class.parse('+34612345678')
        expect(phone).to be_valid
      end

      it 'validates Norwegian number length (8 digits)' do
        phone = described_class.parse('+4712345678')
        expect(phone).to be_valid
      end

      it 'validates Danish number length (8 digits)' do
        phone = described_class.parse('+4512345678')
        expect(phone).to be_valid
      end

      it 'validates Singaporean number length (8 digits)' do
        phone = described_class.parse('+6591234567')
        expect(phone).to be_valid
      end

      it 'validates Chinese number length (11 digits)' do
        phone = described_class.parse('+8613912345678')
        expect(phone).to be_valid
      end

      it 'rejects too-short Mexican number' do
        phone = described_class.parse('+52551234')
        expect(phone).not_to be_valid
      end
    end

    context 'with newly added country formatting' do
      it 'formats Spanish number' do
        phone = described_class.parse('+34612345678')
        expect(phone.formatted).to eq('612 345 678')
      end

      it 'formats Norwegian number' do
        phone = described_class.parse('+4712345678')
        expect(phone.formatted).to eq('123 45 678')
      end

      it 'formats Danish number' do
        phone = described_class.parse('+4512345678')
        expect(phone.formatted).to eq('12 34 56 78')
      end

      it 'formats Polish number' do
        phone = described_class.parse('+48512345678')
        expect(phone.formatted).to eq('512 345 678')
      end

      it 'formats Russian number' do
        phone = described_class.parse('+79161234567')
        expect(phone.formatted).to eq('(916) 123-45-67')
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

      it 'returns false when compared with non-PhoneNumber' do
        expect(us_number == '+15551234567').to be false
      end
    end

    describe '#to_s' do
      it 'returns E.164 string' do
        expect(us_number.to_s).to eq('+15551234567')
      end
    end

    describe '#similar_to?' do
      it 'returns true for two numbers with the same E.164' do
        a = Philiprehberger::Phone.parse('+1 (555) 123-4567')
        b = Philiprehberger::Phone.parse('+15551234567')
        expect(a.similar_to?(b)).to be true
      end

      it 'returns true for numbers parsed with different formatting' do
        a = Philiprehberger::Phone.parse('+1-555-123-4567')
        b = Philiprehberger::Phone.parse('+1.555.123.4567')
        expect(a.similar_to?(b)).to be true
      end

      it 'returns false for different numbers' do
        a = Philiprehberger::Phone.parse('+15551234567')
        b = Philiprehberger::Phone.parse('+15559876543')
        expect(a.similar_to?(b)).to be false
      end

      it 'returns false for numbers from different countries' do
        a = Philiprehberger::Phone.parse('+15551234567')
        b = Philiprehberger::Phone.parse('+442079460958')
        expect(a.similar_to?(b)).to be false
      end

      it 'returns false when compared with non-PhoneNumber' do
        a = Philiprehberger::Phone.parse('+15551234567')
        expect(a.similar_to?('+15551234567')).to be false
      end

      it 'returns true when comparing a number to itself' do
        a = Philiprehberger::Phone.parse('+442079460958')
        expect(a.similar_to?(a)).to be true
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

  describe '#phone_type' do
    context 'with US numbers' do
      it 'detects toll-free number' do
        phone = Philiprehberger::Phone.parse('+18001234567')
        expect(phone.phone_type).to eq(:toll_free)
      end

      it 'detects 888 toll-free number' do
        phone = Philiprehberger::Phone.parse('+18881234567')
        expect(phone.phone_type).to eq(:toll_free)
      end

      it 'detects 877 toll-free number' do
        phone = Philiprehberger::Phone.parse('+18771234567')
        expect(phone.phone_type).to eq(:toll_free)
      end

      it 'detects premium number' do
        phone = Philiprehberger::Phone.parse('+19001234567')
        expect(phone.phone_type).to eq(:premium)
      end

      it 'detects 976 premium number' do
        phone = Philiprehberger::Phone.parse('+19761234567')
        expect(phone.phone_type).to eq(:premium)
      end

      it 'detects mobile number' do
        phone = Philiprehberger::Phone.parse('+12125551234')
        expect(phone.phone_type).to eq(:mobile)
      end
    end

    context 'with UK numbers' do
      it 'detects mobile number (7x prefix)' do
        phone = Philiprehberger::Phone.parse('+447911123456')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects landline number (1x prefix)' do
        phone = Philiprehberger::Phone.parse('+441234567890')
        expect(phone.phone_type).to eq(:landline)
      end

      it 'detects landline number (2x prefix)' do
        phone = Philiprehberger::Phone.parse('+442079460958')
        expect(phone.phone_type).to eq(:landline)
      end

      it 'detects toll-free number' do
        phone = Philiprehberger::Phone.parse('+448001234567')
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with German numbers' do
      it 'detects mobile number (15x prefix)' do
        phone = Philiprehberger::Phone.parse('+4915123456789')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects mobile number (17x prefix)' do
        phone = Philiprehberger::Phone.parse('+4917123456789')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll-free number' do
        phone = Philiprehberger::Phone.parse('+498001234567')
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with French numbers' do
      it 'detects mobile number (6x prefix)' do
        phone = Philiprehberger::Phone.parse('+33612345678')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects mobile number (7x prefix)' do
        phone = Philiprehberger::Phone.parse('+33712345678')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects landline number' do
        phone = Philiprehberger::Phone.parse('+33112345678')
        expect(phone.phone_type).to eq(:landline)
      end
    end

    context 'with Italian numbers' do
      it 'detects mobile number (3x prefix)' do
        phone = Philiprehberger::Phone.parse('+393123456789')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects landline number (0x prefix)' do
        phone = Philiprehberger::Phone.parse('+390612345678')
        expect(phone.phone_type).to eq(:landline)
      end
    end

    context 'with Russian numbers' do
      it 'detects mobile number (9x prefix)' do
        phone = Philiprehberger::Phone.parse('+79161234567')
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll-free number' do
        phone = Philiprehberger::Phone.parse('+78001234567')
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Chinese numbers' do
      it 'detects mobile number (13x prefix)' do
        phone = Philiprehberger::Phone.parse('+8613912345678')
        expect(phone.phone_type).to eq(:mobile)
      end
    end

    context 'with unknown country' do
      it 'returns :unknown for nil country' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: nil)
        expect(phone.phone_type).to eq(:unknown)
      end

      it 'returns :unknown for country without patterns' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '91234567', country: :zz)
        expect(phone.phone_type).to eq(:unknown)
      end
    end
  end

  describe '#area_code_info' do
    context 'with US numbers' do
      it 'returns area code info for New York (212)' do
        phone = Philiprehberger::Phone.parse('+12125551234')
        info = phone.area_code_info
        expect(info).to eq({ area_code: '212', region: 'New York, NY' })
      end

      it 'returns area code info for San Francisco (415)' do
        phone = Philiprehberger::Phone.parse('+14155551234')
        info = phone.area_code_info
        expect(info).to eq({ area_code: '415', region: 'San Francisco, CA' })
      end

      it 'returns area code info for Chicago (312)' do
        phone = Philiprehberger::Phone.parse('+13125551234')
        info = phone.area_code_info
        expect(info).to eq({ area_code: '312', region: 'Chicago, IL' })
      end

      it 'returns area code info for Los Angeles (213)' do
        phone = Philiprehberger::Phone.parse('+12135551234')
        info = phone.area_code_info
        expect(info).to eq({ area_code: '213', region: 'Los Angeles, CA' })
      end

      it 'returns nil for unknown area code' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '9991234567', country: :us)
        expect(phone.area_code_info).to be_nil
      end
    end

    context 'with Canadian numbers' do
      it 'returns area code info for Toronto (416)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '4161234567', country: :ca)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '416', region: 'Toronto, ON' })
      end

      it 'returns area code info for Vancouver (604)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '6041234567', country: :ca)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '604', region: 'Vancouver, BC' })
      end

      it 'returns area code info for Montreal (514)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5141234567', country: :ca)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '514', region: 'Montreal, QC' })
      end
    end

    context 'with UK numbers' do
      it 'returns area code info for London (20)' do
        phone = Philiprehberger::Phone.parse('+442079460958')
        info = phone.area_code_info
        expect(info).to eq({ area_code: '20', region: 'London' })
      end

      it 'returns area code info for Manchester (161)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '44', national: '1611234567', country: :gb)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '161', region: 'Manchester' })
      end

      it 'returns area code info for Edinburgh (131)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '44', national: '1311234567', country: :gb)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '131', region: 'Edinburgh' })
      end
    end

    context 'with German numbers' do
      it 'returns area code info for Berlin (30)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '49', national: '3012345678', country: :de)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '30', region: 'Berlin' })
      end

      it 'returns area code info for Munich (89)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '49', national: '8912345678', country: :de)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '89', region: 'Munich' })
      end

      it 'returns area code info for Hamburg (40)' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '49', national: '4012345678', country: :de)
        info = phone.area_code_info
        expect(info).to eq({ area_code: '40', region: 'Hamburg' })
      end
    end

    context 'with unsupported country' do
      it 'returns nil for country without area code data' do
        phone = Philiprehberger::Phone.parse('+33612345678')
        expect(phone.area_code_info).to be_nil
      end
    end

    context 'with nil country' do
      it 'returns nil' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: nil)
        expect(phone.area_code_info).to be_nil
      end
    end
  end

  describe '.vanity_to_digits' do
    it 'converts 1-800-FLOWERS to digits' do
      result = described_class.vanity_to_digits('1-800-FLOWERS')
      expect(result).to eq('18003569377')
    end

    it 'converts lowercase letters' do
      result = described_class.vanity_to_digits('1-800-flowers')
      expect(result).to eq('18003569377')
    end

    it 'handles mixed case' do
      result = described_class.vanity_to_digits('1-800-Pizza1')
      expect(result).to eq('1800749921')
    end

    it 'preserves digits' do
      result = described_class.vanity_to_digits('1234567890')
      expect(result).to eq('1234567890')
    end

    it 'strips non-alphanumeric characters except digits' do
      result = described_class.vanity_to_digits('+1 (800) GO-FEDEX')
      expect(result).to eq('18004633339')
    end

    it 'handles empty string' do
      result = described_class.vanity_to_digits('')
      expect(result).to eq('')
    end

    it 'converts all letter mappings correctly' do
      result = described_class.vanity_to_digits('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      expect(result).to eq('22233344455566677778889999')
    end

    it 'handles 1-800-COLLECT' do
      result = described_class.vanity_to_digits('1-800-COLLECT')
      expect(result).to eq('18002655328')
    end
  end

  describe '.valid_shortcode?' do
    context 'with US shortcodes' do
      it 'returns true for 5-digit shortcode' do
        expect(described_class.valid_shortcode?('12345', country: :us)).to be true
      end

      it 'returns true for 6-digit shortcode' do
        expect(described_class.valid_shortcode?('123456', country: :us)).to be true
      end

      it 'returns false for 4-digit code' do
        expect(described_class.valid_shortcode?('1234', country: :us)).to be false
      end

      it 'returns false for 7-digit code' do
        expect(described_class.valid_shortcode?('1234567', country: :us)).to be false
      end

      it 'returns false for empty string' do
        expect(described_class.valid_shortcode?('', country: :us)).to be false
      end

      it 'strips non-digit characters' do
        expect(described_class.valid_shortcode?('1-2-3-4-5', country: :us)).to be true
      end

      it 'defaults to US when no country specified' do
        expect(described_class.valid_shortcode?('12345')).to be true
      end
    end

    context 'with other countries' do
      it 'validates UK shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :gb)).to be true
      end

      it 'validates UK shortcode (6 digits)' do
        expect(described_class.valid_shortcode?('123456', country: :gb)).to be true
      end

      it 'validates German shortcode (4 digits)' do
        expect(described_class.valid_shortcode?('1234', country: :de)).to be true
      end

      it 'validates German shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :de)).to be true
      end

      it 'validates French shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :fr)).to be true
      end

      it 'rejects French shortcode (6 digits)' do
        expect(described_class.valid_shortcode?('123456', country: :fr)).to be false
      end

      it 'validates Australian shortcode (6 digits)' do
        expect(described_class.valid_shortcode?('123456', country: :au)).to be true
      end

      it 'rejects Australian shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :au)).to be false
      end
    end

    context 'with newly added countries' do
      it 'validates Brazilian shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :br)).to be true
      end

      it 'validates Mexican shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :mx)).to be true
      end

      it 'validates Japanese shortcode (4 digits)' do
        expect(described_class.valid_shortcode?('1234', country: :jp)).to be true
      end

      it 'validates Japanese shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :jp)).to be true
      end

      it 'validates South Korean shortcode (4 digits)' do
        expect(described_class.valid_shortcode?('1234', country: :kr)).to be true
      end

      it 'rejects South Korean shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :kr)).to be false
      end

      it 'validates Italian shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :it)).to be true
      end

      it 'validates Spanish shortcode (5 digits)' do
        expect(described_class.valid_shortcode?('12345', country: :es)).to be true
      end

      it 'validates Spanish shortcode (6 digits)' do
        expect(described_class.valid_shortcode?('123456', country: :es)).to be true
      end
    end

    context 'with unsupported country' do
      it 'returns false for unknown country' do
        expect(described_class.valid_shortcode?('12345', country: :zz)).to be false
      end
    end
  end

  describe '#carrier' do
    context 'with US numbers' do
      it 'identifies AT&T number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '2125551234', country: :us)
        expect(phone.carrier).to eq('AT&T')
      end

      it 'identifies Verizon number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '3015551234', country: :us)
        expect(phone.carrier).to eq('Verizon')
      end

      it 'identifies T-Mobile number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '4015551234', country: :us)
        expect(phone.carrier).to eq('T-Mobile')
      end

      it 'returns nil for unrecognized prefix' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '9995551234', country: :us)
        expect(phone.carrier).to be_nil
      end
    end

    context 'with Canadian numbers' do
      it 'identifies Rogers number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '4161234567', country: :ca)
        expect(phone.carrier).to eq('Rogers')
      end
    end

    context 'with UK numbers' do
      it 'identifies EE number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '44', national: '7412345678', country: :gb)
        expect(phone.carrier).to eq('EE')
      end
    end

    context 'with German numbers' do
      it 'identifies Telekom number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '49', national: '1511234567', country: :de)
        expect(phone.carrier).to eq('Telekom')
      end
    end

    context 'with nil country' do
      it 'returns nil for nil country' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: nil)
        expect(phone.carrier).to be_nil
      end
    end

    context 'with short national number' do
      it 'returns nil for very short national number' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '12', country: :us)
        expect(phone.carrier).to be_nil
      end
    end
  end

  describe '#to_h' do
    it 'returns a hash with all phone number attributes' do
      phone = described_class.parse('+15551234567')
      result = phone.to_h
      expect(result).to be_a(Hash)
      expect(result[:country_code]).to eq('1')
      expect(result[:national]).to eq('5551234567')
      expect(result[:country]).to eq(:us)
      expect(result[:e164]).to eq('+15551234567')
      expect(result[:formatted]).to eq('(555) 123-4567')
      expect(result[:international]).to eq('+1 (555) 123-4567')
      expect(result[:valid]).to be true
    end

    it 'includes phone_type, area_code_info, and carrier keys' do
      phone = described_class.parse('+12125551234')
      result = phone.to_h
      expect(result).to have_key(:phone_type)
      expect(result).to have_key(:area_code_info)
      expect(result).to have_key(:carrier)
    end
  end

  describe '#inspect' do
    it 'returns a human-readable string with e164 and country' do
      phone = described_class.parse('+15551234567')
      expect(phone.inspect).to eq('#<Philiprehberger::Phone::PhoneNumber +15551234567 (us)>')
    end

    it 'shows unknown for nil country' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: nil)
      expect(phone.inspect).to eq('#<Philiprehberger::Phone::PhoneNumber +9912345 (unknown)>')
    end
  end

  describe '#phone_type for expanded countries' do
    context 'with Netherlands numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '31', national: '612345678', country: :nl)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '31', national: '8001234567', country: :nl)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Swiss numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '41', national: '751234567', country: :ch)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '41', national: '800123456', country: :ch)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Austrian numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '43', national: '6641234567', country: :at)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '43', national: '8001234567', country: :at)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Norwegian numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '47', national: '41234567', country: :no)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '47', national: '80012345', country: :no)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Polish numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '48', national: '512345678', country: :pl)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '48', national: '800123456', country: :pl)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with South African numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '27', national: '712345678', country: :za)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '27', national: '800123456', country: :za)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Argentine numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '54', national: '9123456789', country: :ar)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '54', national: '8001234567', country: :ar)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Colombian numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '57', national: '3123456789', country: :co)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '57', national: '8001234567', country: :co)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Chilean numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '56', national: '912345678', country: :cl)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '56', national: '800123456', country: :cl)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end

    context 'with Egyptian numbers' do
      it 'detects mobile' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '20', national: '1012345678', country: :eg)
        expect(phone.phone_type).to eq(:mobile)
      end

      it 'detects toll_free' do
        phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '20', national: '8001234567', country: :eg)
        expect(phone.phone_type).to eq(:toll_free)
      end
    end
  end

  describe '#country_name' do
    it 'returns the human-readable name for a US number' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5551234567', country: :us)
      expect(phone.country_name).to eq('United States')
    end

    it 'returns nil for an unknown country' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: :zz)
      expect(phone.country_name).to be_nil
    end

    it 'returns nil when country is nil' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '99', national: '12345', country: nil)
      expect(phone.country_name).to be_nil
    end
  end

  describe '#masked' do
    it 'masks everything except the last 4 digits by default' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5551234567', country: :us)
      expect(phone.masked).to eq('+1******4567')
    end

    it 'masks every national digit when visible is 0' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5551234567', country: :us)
      expect(phone.masked(visible: 0)).to eq('+1**********')
    end

    it 'returns full E.164 without overflow when visible exceeds national length' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5551234567', country: :us)
      expect(phone.masked(visible: 99)).to eq('+15551234567')
    end

    it 'preserves a two-digit country code' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '44', national: '2079460958', country: :gb)
      expect(phone.masked(visible: 4)).to eq('+44******0958')
    end

    it 'returns a string of the same length as e164' do
      phone = Philiprehberger::Phone::PhoneNumber.new(country_code: '1', national: '5551234567', country: :us)
      expect(phone.masked(visible: 4).length).to eq(phone.e164.length)
      expect(phone.masked(visible: 0).length).to eq(phone.e164.length)
    end
  end

  describe 'COUNTRIES constant' do
    it 'has at least 30 countries' do
      expect(Philiprehberger::Phone::COUNTRIES.size).to be >= 30
    end

    it 'includes all originally supported countries' do
      %i[us ca gb de fr au jp in br].each do |country|
        expect(Philiprehberger::Phone::COUNTRIES).to have_key(country)
      end
    end

    it 'includes all newly added countries' do
      %i[mx es it nl be ch at se no dk fi pl pt ie ru cn kr sg nz za ng ke eg ar cl co pe].each do |country|
        expect(Philiprehberger::Phone::COUNTRIES).to have_key(country)
      end
    end

    it 'has correct country codes for new countries' do
      expected = {
        mx: '52', es: '34', it: '39', nl: '31', be: '32', ch: '41',
        at: '43', se: '46', no: '47', dk: '45', fi: '358', pl: '48',
        pt: '351', ie: '353', ru: '7', cn: '86', kr: '82', sg: '65',
        nz: '64', za: '27', ng: '234', ke: '254', eg: '20', ar: '54',
        cl: '56', co: '57', pe: '51'
      }
      expected.each do |country, code|
        expect(Philiprehberger::Phone::COUNTRIES[country][:code]).to eq(code), "Expected #{country} code to be #{code}"
      end
    end
  end
end
