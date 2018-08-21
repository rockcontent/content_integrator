module ContentIntegrator
  module Provider
    module Medium
      class TokenExchanger

        attr_reader :code

        def initialize(code)
          @code = code
        end

        def authenticate
          request("/v1/tokens", authentication_params)
        end

        private

        def authentication_params
          {
            code: code,
            client_id: ENV['MEDIUM_KEY'],
            client_secret: ENV['MEDIUM_SECRET'],
            grant_type: "authorization_code",
            redirect_uri: ENV['MEDIUM_REDIRECT']
          }
        end

        def request(endpoint, params)
          JSON.parse(conn[endpoint].post(params))
        rescue RestClient::ExceptionWithResponse => exception
          ConnectionHandler.new(exception).handle
        end

        def conn
          @conn ||= RestClient::Resource.new(API_URL)
        end

      end
    end
  end
end
