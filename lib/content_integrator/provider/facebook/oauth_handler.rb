module ContentIntegrator
  module Provider
    module Facebook

      class OauthHandler

        def initialize(client_id, client_secret, handler = Koala::Facebook::OAuth)
          @handler = handler.new(client_id, client_secret)
        end

        def refresh_token(old_token)
          @refresh_token ||= handler.exchange_access_token_info(old_token)
        end

        private

        attr_reader :handler

      end

    end
  end
end

