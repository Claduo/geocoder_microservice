require 'csv'
module Geocoder
  extend self

  DATA_PATH = Settings.app.geo_data_file_path

  def coordinates(city)
    geo_data = geocode_data.find {|row| row['city'] == city}
    return {errors: I18n.t(:geo_data_not_found, scope: 'lib.errors.geocoder', city: city)} if geo_data.nil?
    coordinates = {lat: geo_data['geo_lat'].to_f, lon: geo_data['geo_lon'].to_f}
    Application.logger.info(
        "Coordinates for '#{city}'",
        city: city,
        geo_data: coordinates
    )
    { geo_data: coordinates }
  end

  private

  def geocode_data
    @data ||= CSV.read(DATA_PATH, headers: true )
  end
end