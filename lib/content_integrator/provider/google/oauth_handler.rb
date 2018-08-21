module ContentIntegrator
  module Provider
    module Google
      class OauthHandler
        AUTHORIZE_URL = "https://accounts.google.com/o/oauth2/auth"
        TOKEN_URL = "https://accounts.google.com/o/oauth2/token"

        def initialize(credential, handler: OAuth2::Client, token_handler: OAuth2::AccessToken)
          @credential = credential
          @handler = handler
          @token_handler = token_handler
        end

        def call
          access_token.refresh!
        end

        private

        attr_reader :credential, :handler, :token_handler

        def access_token
          token_handler.new(client, credential.token,
            refresh_token: credential.refresh_token)
        end

        def client
          handler.new(credential.client_id, credential.client_secret,
            authorize_url: AUTHORIZE_URL, token_url: TOKEN_URL)
        end
      end
    end
  end
end
