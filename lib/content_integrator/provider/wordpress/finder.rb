module ContentIntegrator
  module Provider
    module Wordpress
      class Finder

        def initialize(credential, endpoint, resource_id, resource_attr = :post_id)
          @connection    = Connection.new(credential)
          @endpoint      = endpoint
          @resource_id   = resource_id
          @resource_attr = resource_attr
        end

        def call
          Response.new(content: response)
        end

        private

        attr_reader :connection, :endpoint, :resource_id, :resource_attr

        def response
          connection.get(endpoint, params)
        end

        def params
          { "data" => { "#{resource_attr}" => resource_id } }
        end

      end
    end
  end
end
