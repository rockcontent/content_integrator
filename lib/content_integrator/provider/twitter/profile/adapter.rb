module ContentIntegrator
  module Provider
    module Twitter
      module Profile

        class Adapter
          def initialize(credential)
            @credential = credential
          end

          def connect
            Twitter::Profile::Connector.new(credential).call
          end

          def publish(params)
            Twitter::Profile::Publisher.new(credential, params).call
          end

          private

          attr_reader :credential
        end

      end
    end
  end
end
