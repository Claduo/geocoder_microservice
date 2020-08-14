require_relative 'config/enviroment'

map '/geocode' do
  run GeocodeRoutes
end
