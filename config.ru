require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'app'
ROUTES = {
  '/time' => App.new
}.freeze



use Rack::ContentType, "text/plain"
use Runtime
use AppLogger, logdev: File.expand_path('log/app.log', __dir__)
run Rack::URLMap.new(ROUTES)
