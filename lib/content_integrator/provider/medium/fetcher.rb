module ContentIntegrator
  module Provider
    module Medium
      class Fetcher

        def initialize(credential)
          @credential = credential
        end

        def call
          Response.new(content: normalized_response)
        end

        private

        attr_reader :credential

        def normalized_response
          response.map do |publication|
            {
              id: publication["id"],
              name: publication["name"],
              url: publication["url"],
            }
          end
        end

        def response
          client.publications["data"]
        end

        def client
          @client ||= Client.new(
            access_token: credential.token,
            resource_id: credential.identifier)
        end

      end
    end
  end
end
