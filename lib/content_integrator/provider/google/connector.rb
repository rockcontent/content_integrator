module ContentIntegrator
  module Provider
    module Google
      class Connector
        def initialize(credential, handler: APIHandler)
          @credential = credential
          @handler    = handler
        end

        def call
          build_response!
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error).handle
        end

        def profiles
          conn.profiles
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error).handle
        end

        private

        attr_reader :credential, :handler

        def conn
          @conn ||= handler.new(credential)
        end

        def build_response!
          Response.new(content: content, credentials: credentials)
        end

        def content
          {
            picture_url: info["image"],
            name: info["name"],
            email: info["email"],
          }
        end

        def credentials
          {
            token: token,
            refresh_token: refresh_token,
          }
        end

        def info
          credential.identifier
        end

        def token
          credential.token
        end

        def refresh_token
          credential.refresh_token
        end
      end
    end
  end
end
