module ContentIntegrator
  module Provider
    module Linkedin
      module Page

        class Publisher < BasePublisher
          def initialize(credential, params)
            super(credential, params)
          end

          def call
            super
          end

          private

          def post!
            conn.add_company_share(company_id: identifier, options: options)
          end

          def post_with_link!
            conn.add_company_share(company_id: identifier, options: options_with_link)
          end

          def identifier
            credential.identifier.to_s
          end

        end

      end
    end
  end
end
