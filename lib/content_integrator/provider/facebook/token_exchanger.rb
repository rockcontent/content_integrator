module ContentIntegrator
  module Provider
    module Facebook

      class TokenExchanger

        def initialize(credential, old_token, handler: OauthHandler)
          @credential = credential
          @handler    = handler
          @old_token  = old_token
        end

        def call
          build_response!
        rescue *KOALA_ERRORS => facebook_error
          ErrorHandler.new(facebook_error, details: facebook_error.fb_error_message).handle
        end

        private

        attr_reader :credential, :handler, :old_token

        def build_response!
          Response.new(content: normalized_response)
        end

        def normalized_response
          {
            token:   response["access_token"],
            expires: Utils.parse_expiration_date(response["expires_in"]),
          }
        end

        def response
          @response ||= conn.refresh_token(old_token)
        end

        def conn
          @conn ||= handler.new(credential.client_id, credential.client_secret)
        end

      end

    end
  end
end
