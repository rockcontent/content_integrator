module ContentIntegrator
  module Provider
    module Linkedin
      module Page

        class Adapter
          def initialize(credentials)
            @credentials = credentials
          end

          def connect
            Linkedin::Page::Connector.new(credentials).call
          end

          def publish(params)
            Linkedin::Page::Publisher.new(credentials, params).call
          end

          private

          attr_reader :credentials
        end

      end
    end
  end
end
