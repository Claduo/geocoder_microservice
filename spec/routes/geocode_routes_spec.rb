RSpec.describe GeocodeRoutes, type: :routes do

  subject {get '/v1/', geo_params}

  describe 'GET /geocode' do
    context 'with empty parameters' do
      let(:geo_params) {}
      it 'return error' do
        subject
        expect(last_response.status).to eq(422)
      end
    end

    context 'valid parameters' do
      let(:geo_params) {{ city: 'City 17' }}
      it 'get geocode' do
        subject
        expect(last_response.status).to eq(200)
        expect(response_body['geo_data']).to eq({"lat"=>45.05, "lon"=>90.05})
      end
    end

    context 'with unknown city name' do
      let(:geo_params) {{ city: 'Not City 17' }}

      it 'creates a new ad' do
        subject
        expect(last_response.status).to eq(404)
        expect(response_body['errors']).not_to be_nil
      end
    end

  end
end