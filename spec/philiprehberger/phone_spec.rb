# frozen_string_literal: true

RSpec.describe Philiprehberger::Phone do
  describe '.parse' do
    context 'with US numbers' do
      it 'parses E.164 format' do
        phone = described_class.parse('+15551234567')
        expect(phone.country_code).to eq('1')
        expect(phone.national).to eq('5551234567')
        expect(phone.country).to eq(:us)
      end

      it 'parses formatted number' do
        phone = described_class.parse('+1 (555) 123-4567')
        expect(phone.national).to eq('5551234567')
        expect(phone.country).to eq(:us)
      end

      it 'parses with country hint' do
        phone = described_class.parse('5551234567', country: :us)
        expect(phone.country_code).to eq('1')
        expect(phone.national).to eq('5551234567')
      end
    end

    context 'with UK numbers' do
      it 'parses UK number with country code' do
        phone = described_class.parse('+442079460958')
        expect(phone.country_code).to eq('44')
        expect(phone.country).to eq(:gb)
      end

      it 'parses with country hint' do
        phone = described_class.parse('02079460958', country: :gb)
        expect(phone.country_code).to eq('44')
      end
    end

    context 'with German numbers' do
      it 'parses German number' do
        phone = described_class.parse('+4930123456789')
        expect(phone.country_code).to eq('49')
        expect(phone.country).to eq(:de)
      end
    end

    context 'with Japanese numbers' do
      it 'parses Japanese number' do
        phone = described_class.parse('+81312345678')
        expect(phone.country_code).to eq('81')
        expect(phone.country).to eq(:jp)
      end
    end
  end

  describe '.valid?' do
    it 'returns true for valid US number' do
      expect(described_class.valid?('+15551234567')).to be true
    end

    it 'returns false for too-short number' do
      expect(described_class.valid?('+1555')).to be false
    end

    it 'returns false for empty string' do
      expect(described_class.valid?('')).to be false
    end
  end

  describe Philiprehberger::Phone::Number do
    let(:number) { described_class.new(country_code: '1', national: '5551234567', country: :us) }

    describe '#valid?' do
      it 'returns true for valid number' do
        expect(number).to be_valid
      end

      it 'returns false for wrong length' do
        short = described_class.new(country_code: '1', national: '555', country: :us)
        expect(short).not_to be_valid
      end
    end

    describe '#e164' do
      it 'returns E.164 format' do
        expect(number.e164).to eq('+15551234567')
      end
    end

    describe '#format' do
      it 'returns national format' do
        expect(number.format(:national)).to eq('(555) 123-4567')
      end

      it 'returns international format' do
        expect(number.format(:international)).to eq('+1 (555) 123-4567')
      end

      it 'returns E.164 format' do
        expect(number.format(:e164)).to eq('+15551234567')
      end
    end

    describe '#formatted' do
      it 'returns national format' do
        expect(number.formatted).to eq('(555) 123-4567')
      end
    end

    describe '#international' do
      it 'returns international format' do
        expect(number.international).to eq('+1 (555) 123-4567')
      end
    end

    describe '#country_code' do
      it 'returns the country code' do
        expect(number.country_code).to eq('1')
      end
    end

    describe '#country' do
      it 'returns the country symbol' do
        expect(number.country).to eq(:us)
      end
    end

    describe '#type' do
      it 'returns :unknown by default' do
        expect(number.type).to eq(:unknown)
      end
    end

    describe '#==' do
      it 'compares by E.164' do
        other = described_class.new(country_code: '1', national: '5551234567', country: :us)
        expect(number).to eq(other)
      end
    end

    describe '#to_s' do
      it 'returns E.164 string' do
        expect(number.to_s).to eq('+15551234567')
      end
    end
  end
end
