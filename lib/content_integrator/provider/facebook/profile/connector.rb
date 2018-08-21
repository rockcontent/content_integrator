module ContentIntegrator
  module Provider
    module Facebook
      module Profile

        class Connector < BaseConnector
          def initialize(credentials)
            super(credentials)
          end

          def call
            super
          end

          private

          def pages
            conn.get_pages.inject([]) do |result, page|
              page_info = page.slice("name", "id", "access_token")
              result << Utils.symbolize_keys(page_info) if page_info.any?
              result
            end
          end
        end

      end
    end
  end
end
