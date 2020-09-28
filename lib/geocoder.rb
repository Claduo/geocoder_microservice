require 'csv'
module Geocoder
  extend self

  DATA_PATH = Settings.app.geo_data_file_path

  def coordinates(city)
    start_coding = Time.now.to_f
    geo_data = geocode_data.find {|row| row['city'] == city}
    duration_time = (Time.now.to_f - start_coding) * 1000
    return {errors: I18n.t(:geo_data_not_found, scope: 'lib.errors.geocoder', city: city)} if geo_data.nil?
    coordinates = {lat: geo_data['geo_lat'].to_f, lon: geo_data['geo_lon'].to_f}
    Application.logger.info(
        "Coordinates for '#{city}'",
        city: city,
        geo_data: coordinates
    )
    Metrics.geocoding_duration_milliseconds.observe(duration_time.round, labels: { city: city })
    { geo_data: coordinates }
  end

  private

  def geocode_data
    @data ||= CSV.read(DATA_PATH, headers: true )
  end
end