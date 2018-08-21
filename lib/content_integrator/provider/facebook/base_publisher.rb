module ContentIntegrator
  module Provider
    module Facebook

      PICTURE   = "picture"
      WALL_POST = "wall_post"

      class BasePublisher
        def initialize(credential, params, handler: APIHandler)
          @params     = params
          @credential = credential
          @handler    = handler
        end

        protected

        def call
          manage_response!
        rescue *KOALA_ERRORS => facebook_error
          ErrorHandler.new(facebook_error, details: facebook_error.fb_error_message).handle
        end

        private

        attr_reader :credential, :handler, :params

        def manage_response!
          response = manage_publication! || {}
          response.merge!({ publication_type: publication_type })

          Response.new(content: Utils.symbolize_keys(response))
        end

        def manage_publication!
          if publication_type == PICTURE
            put_picture!
          else
            put_wall_post!
          end
        end

        def put_wall_post!
          conn.put_wall_post(content, link)
        end

        def put_picture!
          conn.put_picture(picture_url, content)
        end

        def publication_type
          return PICTURE if !picture_url.empty? && link.empty?
          WALL_POST
        end

        def picture_url
          params[:picture].to_s
        end

        def content
          params[:content].to_s
        end

        def link
          params[:link].to_s
        end

        def conn
          @conn ||= handler.new(credential.token)
        end
      end

    end
  end
end
