module ContentIntegrator
  module Provider
    module Google
      RESCUABLE_ERRORS = [ OAuth2::Error, Rack::Timeout::RequestTimeoutException ]

      class ErrorHandler
        def initialize(error)
          @error = error
        end

        def handle
          case error
          when OAuth2::Error
            validation_error if code_message
            raise ConnectionError.new(code, details: error.description.to_s)
          when Rack::Timeout::RequestTimeoutException
            raise ConnectionError.new("timeout", details: error.message)
          end
        end

        private

        attr_reader :error

        def validation_error
          case code_message
          when "User does not have any Google Analytics account."
            raise ValidationError.new("invalid_account", details: code_message)
          end
        end

        def code_message
          code["message"] if code.is_a?(Hash)
        end

        def code
          error.code
        end
      end
    end
  end
end
