module ContentIntegrator
  module Provider
    module Twitter
      module Profile

        class Publisher < Base
          def initialize(credential, params)
            super(credential)
            @params  = params
          end

          def call
            manage_response!
          rescue *TWITTER_ERRORS => twitter_error
            ErrorHandler.new(twitter_error, details: twitter_error.message).handle
          rescue *OPEN_URI_ERRORS => open_uri_error
            ErrorHandler.new(open_uri_error, details: open_uri_error.message).handle
          end

          private

          attr_reader :params

          def manage_response!
            response = manage_publication!

            Response.new(content: { id: response.id })
          end

          def manage_publication!
            if !link.empty?
              body = "#{content} #{link}".strip
              conn.post(body)
            else
              conn.post(content, picture_url)
            end
          end

          def link
            params[:link].to_s
          end

          def picture_url
            params[:picture].to_s
          end

          def content
            params[:content].to_s
          end
        end

      end
    end
  end
end
