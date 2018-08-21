module ContentIntegrator
  module Provider
    module Twitter

      class APIHandler
        def initialize(token, secret, client_id, client_secret, handler = ::Twitter::REST::Client)
          @handler = handler.new({
            access_token: token,
            access_token_secret: secret,
            consumer_key: client_id,
            consumer_secret: client_secret
          })
        end

        def account_id
          profile.id
        end

        def account_name
          profile.name
        end

        def picture_data
          profile.profile_image_url.to_str
        end

        def post(content, picture_url = nil)
          handler.update(content, media_ids: twitter_media(picture_url))
        end

        private

        attr_reader :handler

        def profile
          @profile ||= handler.user
        end

        def twitter_media(picture_url)
          handler.upload(Utils.open_image_from_url(picture_url)) unless picture_url.to_s.empty?
        end
      end

    end
  end
end
