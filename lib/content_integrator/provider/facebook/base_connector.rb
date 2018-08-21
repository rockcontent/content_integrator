module ContentIntegrator
  module Provider
    module Facebook

      class BaseConnector
        def initialize(credential, handler: APIHandler)
          @credential = credential
          @handler    = handler
        end

        protected

        def call
          build_response!
        rescue *KOALA_ERRORS => facebook_error
          ErrorHandler.new(facebook_error, details: facebook_error.fb_error_message).handle
        end

        private

        attr_reader :credential, :handler

        def build_response!
          Response.new(content: details, credentials: credentials)
        end

        def details
          {
            name: account_name,
            picture_url: picture,
            pages: pages,
          }
        end

        def credentials
          {
            token: credential.token,
            identifier: account_id,
            secret: nil,
          }
        end

        def account_id
          conn.account_object.dig("id")
        end

        def account_name
          conn.account_object.dig("name")
        end

        def picture
          conn.picture_data.dig("data", "url")
        end

        def conn
          @conn ||= handler.new(credential.token)
        end

        def pages
          raise NotImplementedError
        end
      end

    end
  end
end
