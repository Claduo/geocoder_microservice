require "prometheus/client"
require "prometheus/middleware/exporter"

Metrics.configure do |registry|
  registry.counter(
      :geocoding_requests_total,
      docstring: "the total number of geocoding requests.",
      labels: %i[result]
  )
  registry.histogram(
      :geocoding_duration_milliseconds,
      docstring: "geocoding duration",
      labels: %i[city]
  )
end
