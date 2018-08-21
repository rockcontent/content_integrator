module ContentIntegrator
  module Provider
    module Medium
      class Client

        attr_reader :access_token, :resource_id

        def initialize(access_token:, resource_id:)
          @access_token = access_token
          @resource_id  = resource_id
        end

        def user
          request(:get, "/v1/me")
        end

        def publications
          request(:get, "/v1/users/#{resource_id}/publications")
        end

        def post(params)
          request(:post, "/v1/users/#{resource_id}/posts", params)
        end

        def post_publication(params)
          request(:post, "/v1/publications/#{resource_id}/posts", params)
        end

        private

        def request(method, endpoint, params = {})
          JSON.parse(conn[endpoint].public_send(method, params))
        rescue RestClient::ExceptionWithResponse => exception
          ConnectionHandler.new(exception).handle
        end

        def conn
          RestClient::Resource.new(API_URL, headers: headers)
        end

        def headers
          {
            "Authorization": "Bearer #{access_token}"
          }
        end
      end
    end
  end
end
