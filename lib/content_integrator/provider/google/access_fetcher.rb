module ContentIntegrator
  module Provider
    module Google
      class AccessFetcher
        def initialize(credential, date, handler: APIHandler)
          @credential = credential
          @handler    = handler
          @date       = date
          @accesses   = []
        end

        def call
          fetch!
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error).handle
        end

        private

        attr_reader :credential, :handler, :date, :accesses

        def fetch!
          conn.accesses(date).each do |result|
            if UriPathValidator.new(result.pagePath).valid?
              post = AccessParser.new(result, accesses).parse
              post[:accesses] << {
                sessions: result.sessions.to_i,
                source: result.medium
              }
            end
          end
          accesses
        end

        def conn
          @conn ||= handler.new(credential)
        end
      end
    end
  end
end
