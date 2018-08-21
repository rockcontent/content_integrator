module ContentIntegrator
  module Provider
    module Twitter

      TWITTER_ERRORS = [
        ::Twitter::Error::Unauthorized, ::Twitter::Error::BadRequest,
        ::Twitter::Error::ConfigurationError, ::Twitter::Error::Forbidden,
        ::Twitter::Error::DuplicateStatus, ::Twitter::Error::UnacceptableIO
      ]

      OPEN_URI_ERRORS = [ OpenURI::HTTPError ]

      class ErrorHandler

        attr_reader :error, :details

        def initialize(error, details = nil)
          @error   = error
          @details = details
        end

        def handle
          case error
          when ::Twitter::Error::Unauthorized
            raise InvalidCredentialsError.new("authentication_error", details: details)
          when ::Twitter::Error::BadRequest, ::Twitter::Error::ConfigurationError
            raise ConnectionError.new("connection_failed", details: details)
          when ::Twitter::Error::Forbidden, ::Twitter::Error::DuplicateStatus,
            ::Twitter::Error::UnacceptableIO, OpenURI::HTTPError
            raise ValidationError.new("validation_error", details: details)
          end
        end

      end

    end
  end
end
