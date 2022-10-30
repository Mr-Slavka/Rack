require_relative 'time_formatter'

class App

  def call(env)
    perform_response(env)
  end

  private

  def perform_response(env)
    request = Rack::Request.new(env)
    request_params = request.params['format']
    return [400, headers, ["invalid_format_name\n"]] if request_params.nil?

    call_formatter(request_params)

  end

  def call_formatter(request_params)
    formatter = TimeFormatter.new(request_params)
    if formatter.valid?
      body = formatter.call
      status = 200
    else
      invalid_params = formatter.invalid.join(', ')
      body = "Unknown time format #{invalid_params}"
      status = 400

    end
    [status, headers, ["#{body}\n"]]
  end

  def headers
    {}
  end

end
