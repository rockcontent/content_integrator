module ContentIntegrator
  module Provider
    module Wordpress
      class Connector

        attr_reader :connection, :response

        def initialize(credential)
          @connection = Connection.new(credential)
        end

        def call
          response = connection.post(ENDPOINTS[:activate], nil)
          inject_redirect_link(response)
          build_response
        end

        private

        def inject_redirect_link(http_response)
          http_response["data"]["redirect_path"] = "#{http_response["credentials"]["url"]}/#{redirect_link}"
          @response = http_response
        end

        def redirect_link
          "wp-admin/admin.php?page=rcp_plugin_options&integrated=success"
        end

        def build_response
          Response.new(content: response["data"], credentials: response["credentials"])
        end

      end
    end
  end
end
