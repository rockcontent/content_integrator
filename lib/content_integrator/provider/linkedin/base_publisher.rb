module ContentIntegrator
  module Provider
    module Linkedin

      DEFAULT_VISIBILITY = "anyone"

      class BasePublisher
        def initialize(credential, params, handler: APIHandler)
          @credential = credential
          @params     = params
          @handler    = handler
        end

        protected

        def call
          manage_response!
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error, details: error.message).handle
        end

        def post!
          raise NotImplementedError
        end

        def post_with_link!
          raise NotImplementedError
        end

        def conn
          @conn = handler.new(credential.token)
        end

        private

        attr_reader :credential, :handler, :params

        def manage_response!
          response = manage_publication!
          body     = JSON.parse(response.body)

          Response.new(content: Utils.symbolize_keys(body))
        end

        def manage_publication!
          return post_with_link! if !link.empty?

          post!
        end

        def picture?
          !picture_url.empty?
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

        def title
          params[:title].to_s
        end

        def visibility
          params[:visibility] || DEFAULT_VISIBILITY
        end

        def options
          { comment: content, visibility: { code: visibility } }
        end

        def options_with_link
          body = { "title": title, "submitted-url": link }
          body.merge!("submitted-image-url": picture_url) if picture?

          options.merge({ content: body })
        end
      end

    end
  end
end
