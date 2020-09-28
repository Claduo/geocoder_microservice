require_relative 'config/enviroment'

use Rack::Deflater
use Prometheus::Middleware::Exporter
use Rack::Ougai::LogRequests, Application.logger

map '/geocode' do
  run GeocodeRoutes
end
