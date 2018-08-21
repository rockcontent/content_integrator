module ContentIntegrator
  module Provider
    module Linkedin

      # 'linkedin-oauth2' gem errors
      LINKEDIN_ERRORS = [ LinkedIn::InvalidRequest ]

      # 'linkedin-oauth2' gem raises Faraday exceptions
      FARADAY_ERRORS = [ Faraday::ClientError ]

      RESCUABLE_ERRORS = FARADAY_ERRORS + LINKEDIN_ERRORS

      class ErrorHandler

        attr_reader :error, :details

        def initialize(error, details = nil)
          @error   = error
          @details = details
        end

        def handle
          case error
          when LinkedIn::InvalidRequest
            raise InvalidCredentialsError.new("authentication_error", details: details)
          when Faraday::ClientError
            raise ConnectionError.new("connection_failed", details: details)
          end
        end

      end

    end
  end
end
