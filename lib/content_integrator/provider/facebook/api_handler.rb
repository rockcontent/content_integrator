module ContentIntegrator
  module Provider
    module Facebook

      class APIHandler

        def initialize(token, handler = Koala::Facebook::API)
          @handler = handler.new(token)
        end

        def get_pages
          @get_pages ||= handler.get_connections("me", "accounts")
        end

        def account_object
          @account_object ||= handler.get_object("me")
        end

        def picture_data
          @picture_data ||= handler.get_picture_data("me")
        end

        def put_wall_post(content, link)
          handler.put_wall_post(content, { link: link })
        end

        def put_picture(picture_url, content)
          handler.put_picture(picture_url, { caption: content })
        end

        private

        attr_reader :handler

      end

    end
  end
end
