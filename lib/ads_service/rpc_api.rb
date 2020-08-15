module AdsService
  module RpcApi
    def update_coordinates(id, coordinates)
      coordinates = prepare_coordinates(coordinates)
      payload = {id: id, coordinates: coordinates}.to_json
      publish(payload, type: 'update_coordinates')
    end

    def prepare_coordinates(coordinates)
      if !!coordinates[:geo_data]
        [coordinates[:geo_data][:lat], coordinates[:geo_data][:lon]]
      else
        [0,0]
      end
    end
  end
end