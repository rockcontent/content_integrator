module ContentIntegrator
  module Provider
    module Wordpress

      CONNECTION_ERRORS = [ OpenSSL::Cipher::CipherError, OpenSSL::SSL::SSLError ]
      RESCUABLE_ERRORS  = [ *CONNECTION_ERRORS, JSON::ParserError ]

      class ErrorHandler

        attr_reader :error, :details

        def initialize(error, details = nil)
          @error   = error
          @details = details
        end

        def handle
          case error
          when *CONNECTION_ERRORS
            raise ConnectionError.new("connection_failed", details: details)
          when JSON::ParserError
            raise InvalidResponseError.new("invalid_response", details: details)
          end
        end

      end
    end
  end
end
