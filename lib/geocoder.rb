require 'csv'
module Geocoder
  extend self

  def coordinates(city)
    geo_data = geocode_data.find {|row| row['city'] == city}
    return {errors: I18n.t(:geo_data_not_found, scope: 'lib.errors.geocoder', city: city)} if geo_data.nil?
    { geo_data: {lat: [geo_data['geo_lat'].to_f, lon: geo_data['geo_lon'].to_f]} }
  end

  private

  def geocode_data
    @data ||= CSV.read( Settings.app.geo_data_file_path, headers: true )
  end
end