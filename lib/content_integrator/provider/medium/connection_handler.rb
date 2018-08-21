module ContentIntegrator
  module Provider
    module Medium
      class ConnectionHandler

        attr_reader :exception

        def initialize(exception)
          @exception = exception
        end

        def handle
          code, message = error.fetch_values("code", "message")
          ErrorHandler.new(code, message).handle
        end

        private

        def error
          JSON.parse(exception.response.body)["errors"].first
        end

      end
    end
  end
end
