module ContentIntegrator
  module Provider
    module Medium
      class Connector

        attr_reader :code, :token, :user

        def initialize(credentials)
          @code = credentials.token
        end

        def call
          @token = TokenExchanger.new(code).authenticate
          @user = client.user["data"]
          build_response
        end

        private

        attr_reader :http_response

        def client
          Client.new(access_token: token["access_token"], resource_id: nil)
        end

        def build_response
          Response.new(content: data, credentials: credentials)
        end

        def data
          {
            picture_url: user["imageUrl"],
            name: user["name"],
            username: user["username"]
          }
        end

        def credentials
          {
            identifier: user["id"],
            token: token["access_token"],
            secret: token["refresh_token"],
            url: user["url"]
          }
        end

      end
    end
  end
end
