module ContentIntegrator
  module Provider
    module Linkedin
      module Profile

        class Adapter
          def initialize(credentials)
            @credentials = credentials
          end

          def connect
            Linkedin::Profile::Connector.new(credentials).call
          end

          def publish(params)
            Linkedin::Profile::Publisher.new(credentials, params).call
          end

          private

          attr_reader :credentials
        end

      end
    end
  end
end
