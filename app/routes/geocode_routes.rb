class GeocodeRoutes < Application
  namespace '/v1' do
    get '/' do
      geocoder_params = validate_with!(GeocoderParamsContract)
      result = Geocoder.coordinates(geocoder_params[:city])
      if result[:errors].nil? && !!result[:geo_data]
        status 200
        json geo_data: result[:geo_data]
      else
        error_response(result[:errors], 404)
      end
    end
  end
end