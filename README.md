# README

This application just uses the `prometheus-client` gem in order to expose the traffic related metrics under the route `/metrics`.

### Info

Based on [this article](https://www.robustperception.io/instrumenting-a-ruby-on-rails-application-with-prometheus) what we actually needed was:

* `Gemfile`

```
gem 'prometheus-client'
```

* `config.ru`

```
require_relative 'config/environment'
require 'prometheus/middleware/collector'
require 'prometheus/middleware/exporter'

use Prometheus::Middleware::Collector
use Prometheus::Middleware::Exporter
run Rails.application
```

The above are what was needed in order to get the metrics.

### How to build the image

```
docker build -t igiannoulas/rails-with-prometheus-metrics:v0.0.1 .
docker push igiannoulas/rails-with-prometheus-metrics:v0.0.1
```

### How to deploy on EYK

```
eyk apps:create railsprom --no-remote
eyk config:set PORT=5000 RAILS_LOG_TO_STDOUT=true --app=railsprom
eyk builds:create igiannoulas/rails-with-prometheus-metrics:v0.0.1 --procfile="{web: bundle exec rails s -b 0.0.0.0 -p 5000}" --app=railsprom
```

