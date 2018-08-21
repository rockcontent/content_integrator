module ContentIntegrator
  module Provider
    module Facebook
      module Profile

        class Publisher < BasePublisher
          def initialize(credentials, params)
            super(credentials, params)
          end

          def call
            super
          end
        end

      end
    end
  end
end
