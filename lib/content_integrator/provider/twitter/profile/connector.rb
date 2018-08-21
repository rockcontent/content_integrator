module ContentIntegrator
  module Provider
    module Twitter
      module Profile

        class Connector < Base
          def initialize(credential)
            super(credential)
          end

          def call
            build_response!
          rescue *TWITTER_ERRORS => twitter_error
            ErrorHandler.new(twitter_error, details: twitter_error.message).handle
          end

          private

          def build_response!
            Response.new(content: details, credentials: credentials)
          end

          def details
            {
              name: account_name,
              picture_url: picture,
              pages: [],
            }
          end

          def credentials
            {
              token: credential.token,
              identifier: identifier,
              secret: credential.secret,
            }
          end

          def identifier
            conn.account_id
          end

          def account_name
            conn.account_name
          end

          def picture
            conn.picture_data
          end
        end

      end
    end
  end
end
