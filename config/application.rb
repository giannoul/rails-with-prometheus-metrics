require_relative 'boot'

require 'rails/all'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'
require_relative '../lib/middlewares/metrics_route_filter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PrometheusMetrics
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.middleware.use MetricsRouteFilter
    config.middleware.use Prometheus::Middleware::Collector
    config.middleware.use Prometheus::Middleware::Exporter
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
