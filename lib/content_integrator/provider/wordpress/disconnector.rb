module ContentIntegrator
  module Provider
    module Wordpress
      class Disconnector

        attr_reader :connection

        def initialize(credential)
          @connection = Connection.new(credential)
        end

        def call
          response = connection.get(ENDPOINTS[:disconnect])
          Response.new(content: response)
        end

      end
    end
  end
end
