module ContentIntegrator
  module Provider
    module Linkedin

      class BaseConnector
        def initialize(credential, handler: APIHandler)
          @credential = credential
          @handler    = handler
        end

        protected

        def call
          build_response!
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error, details: error.message).handle
        end

        def conn
          @conn ||= handler.new(credential.token)
        end

        private

        attr_reader :credential, :handler

        def build_response!
          Response.new(content: details, credentials: credentials)
        end

        def credentials
          {
            token: credential.token,
            identifier: identifier,
            secret: nil
          }
        end

        def details
          {
            name: account_name,
            picture_url: picture,
            pages: pages
          }
        end

        def identifier
          raise NotImplementedError
        end

        def account_name
          raise NotImplementedError
        end

        def picture
          raise NotImplementedError
        end

        def pages
          raise NotImplementedError
        end
      end

    end
  end
end
