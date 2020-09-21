require_relative 'config/enviroment'

use Rack::Ougai::LogRequests, Application.logger

map '/geocode' do
  run GeocodeRoutes
end
