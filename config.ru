require_relative 'config/enviroment'

run Rack::URLMap.new(
    '/v1/auth' => AuthRoutes,
    '/v1/login' => UserSessionRoutes,
    '/v1/signup' => UserRoutes
)
