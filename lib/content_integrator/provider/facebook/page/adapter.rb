module ContentIntegrator
  module Provider
    module Facebook
      module Page

        class Adapter
          def initialize(credentials)
            @credentials = credentials
          end

          def connect
            Facebook::Page::Connector.new(credentials).call
          end

          def publish(params)
            Facebook::Page::Publisher.new(credentials, params).call
          end

          private

          attr_reader :credentials
        end

      end
    end
  end
end
