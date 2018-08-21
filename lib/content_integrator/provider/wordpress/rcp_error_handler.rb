module ContentIntegrator
  module Provider
    module Wordpress
      class RcpErrorHandler

        RCP_ERRORS = {
          invalid_credentials_errors: {
            "TK01" => "INVALID_TOKEN",
            "TK02" => "TOKEN_NOT_PROVIDED",
            "IT01" => "INTEGRATION_FAILED"
          },
          validation_errors: {
            "PP01" => "INVALID_POST_FIELDS",
            "PP02" => "INVALID_WP_POST_FIELDS",
            "LP01" => "POST_STATUS_REQUIRED",
          }
        }

        def initialize(error)
          @error = error
        end

        def handle
          raise error_exception
        end

        private

        attr_reader :error

        def error_exception
          case error_code
          when *RCP_ERRORS[:invalid_credentials_errors].keys
            InvalidCredentialsError.new("invalid_credentials", details: error_message)
          when *RCP_ERRORS[:validation_errors].keys
            ValidationError.new("validation_error", details: error_message)
          else
            UnknownError.new("unknown_error", details: error_message)
          end
        end

        def error_code
          parsed_response["error_code"]
        end

        def error_message
          parsed_response["error"] || parsed_response["errors"] || "error_not_found"
        end

        def parsed_response
          JSON.parse error.response.body
        rescue JSON::ParserError => err
          ErrorHandler.new(err, error.class).handle
        end

      end
    end
  end
end
