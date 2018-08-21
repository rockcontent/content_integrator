module ContentIntegrator
  module Provider
    module Medium

      API_URL = "https://api.medium.com"
      SCOPES  = %w(basicProfile listPublications publishPost)

      def self.authorization_url
        params = {
          client_id: ENV['MEDIUM_KEY'],
          redirect_uri: ENV['MEDIUM_REDIRECT'],
          scope: SCOPES.join(","),
          state: SecureRandom.hex,
          response_type: "code"
        }

        "https://medium.com/m/oauth/authorize?#{params.to_query}"
      end

    end
  end
end

require_relative "medium/utils"
require_relative "medium/error_handler"
require_relative "medium/connection_handler"
require_relative "medium/connector"
require_relative "medium/fetcher"
require_relative "medium/token_exchanger"
require_relative "medium/client"
require_relative "medium/publisher"
require_relative "medium/adapter"
