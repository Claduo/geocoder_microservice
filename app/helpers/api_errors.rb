require 'sinatra/extension'

module ApiErrors
  extend Sinatra::Extension

  helpers do
    def error_response(error_messages, status_code)
      errors = ErrorSerializer.from_messages(error_messages)
      status status_code
      json errors
    end
  end

  error Validations::InvalidParams do
    error_response(I18n.t(:missing_parameters, scope: 'api.errors'), 422)
  end
end