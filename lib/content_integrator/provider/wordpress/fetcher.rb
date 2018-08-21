module ContentIntegrator
  module Provider
    module Wordpress
      class Fetcher

        def initialize(credential, endpoint)
          @connection = Connection.new(credential)
          @endpoint   = endpoint
        end

        def call
          Response.new(content: normalized_response)
        end

        private

        attr_reader :connection, :endpoint

        def normalized_response
          response.map do |resource|
            {
              id: resource[id_attr].to_s,
              name: resource[name_attr],
            }
          end
        end

        def response
          connection.get(endpoint)
        end

        def name_attr
          case endpoint
          when ENDPOINTS[:users]
            "display_name"
          when ENDPOINTS[:categories]
            "name"
          end
        end

        def id_attr
          case endpoint
          when ENDPOINTS[:users]
            "user_id"
          when ENDPOINTS[:categories]
            "term_id"
          end
        end
      end
    end
  end
end
