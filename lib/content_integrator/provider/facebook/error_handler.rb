module ContentIntegrator
  module Provider
    module Facebook

      KOALA_ERRORS = [
        Koala::Facebook::AuthenticationError, Koala::Facebook::BadFacebookResponse,
        Koala::Facebook::ClientError, Koala::Facebook::OAuthTokenRequestError,
        Koala::Facebook::ServerError
      ]

      class ErrorHandler

        attr_reader :error, :details

        def initialize(error, details = nil)
          @error   = error
          @details = details
        end

        def handle
          case error
          when Koala::Facebook::AuthenticationError
            raise InvalidCredentialsError.new("Authentication error", details: details)
          when Koala::Facebook::ClientError, Koala::Facebook::ServerError,
            Koala::Facebook::BadFacebookResponse, Koala::Facebook::OAuthTokenRequestError
            raise ConnectionError.new("Connection Failed", details: details)
          end
        end

      end

    end
  end
end
