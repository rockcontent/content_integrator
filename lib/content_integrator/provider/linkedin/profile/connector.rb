module ContentIntegrator
  module Provider
    module Linkedin
      module Profile

        class Connector < BaseConnector
          def initialize(credentials)
            super(credentials)
          end

          def call
            super
          end

          private

          def identifier
            conn.profile.id
          end

          def account_name
            full_name
          end

          def picture
            conn.profile_picture_data
          end

          def pages
            conn.get_pages.inject([]) do |result, page|
              page_info = page.slice("name", "id")
              result << Utils.symbolize_keys(page_info) if page_info.any?
              result
            end
          end

          def full_name
            "#{first_name} #{last_name}"
          end

          def first_name
            conn.profile.first_name
          end

          def last_name
            conn.profile.last_name
          end
        end

      end
    end
  end
end
