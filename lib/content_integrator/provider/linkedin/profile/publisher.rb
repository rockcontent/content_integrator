module ContentIntegrator
  module Provider
    module Linkedin
      module Profile

        class Publisher < BasePublisher
          def initialize(credential, params)
            super(credential, params)
          end

          def call
            super
          end

          private

          def post!
            conn.add_share(options: options)
          end

          def post_with_link!
            conn.add_share(options: options_with_link)
          end
        end

      end
    end
  end
end
