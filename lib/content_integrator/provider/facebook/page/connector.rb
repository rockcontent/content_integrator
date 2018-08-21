module ContentIntegrator
  module Provider
    module Facebook
      module Page

        class Connector < BaseConnector
          def initialize(credentials)
            super(credentials)
          end

          def call
            super
          end

          private

          # A page connection should return an empty information about subpages
          # because a page does not have subpages
          def pages
            []
          end
        end

      end
    end
  end
end
