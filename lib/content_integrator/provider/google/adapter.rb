module ContentIntegrator
  module Provider
    module Google
      class Adapter
        def initialize(credentials)
          @credentials = credentials
        end

        def connect
          connector.call
        end

        def accesses(date:)
          AccessFetcher.new(credentials, date).call
        end

        def profiles
          connector.profiles
        end

        private

        attr_reader :credentials

        def connector
          Connector.new(credentials)
        end
      end
    end
  end
end
