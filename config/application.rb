# frozen_string_literal: true
require "sinatra/custom_logger"
class Application < Sinatra::Base
  helpers Sinatra::CustomLogger
  helpers Validations

  # для логгирования синхронного запроса
  before { Thread.current[:request_id] ||= request.env["HTTP_X_REQUEST_ID"] }

  configure do
    register Sinatra::Namespace
    register ApiErrors
    set :app_file, File.expand_path('../config.ru', __dir__)
  end

  configure :development do
    register Sinatra::Reloader
    set :show_exceptions, false
  end
end