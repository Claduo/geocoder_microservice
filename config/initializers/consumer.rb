channel = RabbitMq.consumer_chanel
queue = channel.queue('geocoding', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  Thread.current[:request_id] = properties.headers['request_id']
  payload = JSON(payload)
  coordinates = Geocoder.coordinates(payload['city'])

  if coordinates[:geo_data].present?
    client = AdsService::RpcClient.fetch
    client.update_coordinates(payload['id'], coordinates)
    geocoding_status = "success"
  else
    geocoding_status = "failed"
  end
  Metrics.geocoding_requests_total.increment(labels: { result: geocoding_status })

  channel.ack(delivery_info.delivery_tag)
end
