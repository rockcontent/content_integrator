module ContentIntegrator
  module Provider
    module Facebook
      module Profile

        class Adapter
          def initialize(credentials)
            @credentials = credentials
          end

          def connect
            Facebook::Profile::Connector.new(credentials).call
          end

          def publish(params)
            Facebook::Profile::Publisher.new(credentials, params).call
          end

          private

          attr_reader :credentials
        end

      end
    end
  end
end
