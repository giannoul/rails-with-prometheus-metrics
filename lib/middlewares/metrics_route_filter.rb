class MetricsRouteFilter
    def initialize app
      @app = app
    end
  
    def call env
      @status, @headers, @response = @app.call(env)
  
      Rails.logger.debug "=" * 50
      Rails.logger.debug "Request IP: #{env['REMOTE_ADDR']} "
      Rails.logger.debug "Request Path: #{env['REQUEST_PATH']} "
      Rails.logger.debug "Request UserAgent: #{env['HTTP_USER_AGENT']} "
      
      if env['REQUEST_PATH'] == "/metrics"
        if is_prometheus(env['REMOTE_ADDR'], env['HTTP_USER_AGENT'])
          Rails.logger.debug "Proceed with request"
          Rails.logger.debug "=" * 50
          [@status, @headers, @response]
        else
          Rails.logger.debug "Block request"
          Rails.logger.debug "=" * 50
          forbidden
        end
      else
        Rails.logger.debug "Proceed with request"
        Rails.logger.debug "=" * 50
        [@status, @headers, @response]
      end

      
    end

    def forbidden
      [403, {"Content-Type" => "text/plain"}, ["Forbidden!"]]
    end

    def is_prometheus(ip, user_agent)
      (ip.split(".")[0] == "10") && (user_agent.include? "Prometheus")
    end

  end