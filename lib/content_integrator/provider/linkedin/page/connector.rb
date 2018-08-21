module ContentIntegrator
  module Provider
    module Linkedin
      module Page

        class Connector < BaseConnector
          def initialize(credential)
            super(credential)
            @company_id = credential.identifier
          end

          def call
            super
          end

          private

          attr_reader :company_id

          def identifier
            company_id
          end

          def account_name
            company_data.name
          end

          def picture
            company_data.logo_url
          end

          def pages
            []
          end

          def company_data
            @company_data ||= conn.company(company_id)
          end
        end

      end
    end
  end
end
