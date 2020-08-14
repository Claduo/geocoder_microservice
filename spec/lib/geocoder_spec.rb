RSpec.describe Geocoder do
  subject { described_class }

  describe '.geocode' do
    context 'existing city' do
      it 'returns coordinates' do
        result = subject.coordinates('City 17')

        expect(result[:geo_data][:lat]).to eq(45.05)
        expect(result[:geo_data][:lon]).to eq(90.05)
      end
    end

    context 'missing city' do
      it 'returns a nil value' do
        result = subject.coordinates('Missing')
        expect(result[:geo_data]).to be_nil
      end
    end
  end
end
