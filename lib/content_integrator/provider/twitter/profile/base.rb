module ContentIntegrator
  module Provider
    module Twitter
      module Profile

        class Base
          def initialize(credential, handler: APIHandler)
            @credential = credential
            @handler    = handler
          end

          protected

          attr_reader :handler, :credential

          def conn
            @conn ||= handler.new(credential.token,
                                  credential.secret,
                                  credential.client_id,
                                  credential.client_secret)
          end
        end

      end
    end
  end
end
