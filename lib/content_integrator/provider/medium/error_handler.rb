module ContentIntegrator
  module Provider
    module Medium

      CREDENTIALS_ERRORS = [ 6016, 6003 ]
      VALIDATION_ERRORS  = [ 2002, 6007 ]
      FORBIDDEN_ERRORS   = [ 2006 ]

      class ErrorHandler

        attr_reader :error_code, :message

        def initialize(error_code, message)
          @error_code = error_code
          @message    = message
        end

        def handle
          case error_code
          when *CREDENTIALS_ERRORS
            raise InvalidCredentialsError.new("invalid_token", details: message)
          when *VALIDATION_ERRORS
            raise ValidationError.new("validation_error", details: message)
          when *FORBIDDEN_ERRORS
            raise ForbiddenError.new("invalid_publication", details: message)
          end
        end

      end
    end
  end
end
