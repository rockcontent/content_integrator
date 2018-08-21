module ContentIntegrator
  module Provider
    module Wordpress
      class Connection

        attr_reader :base_url, :token

        def initialize(credential)
          @base_url = credential.url
          @token    = credential.token

          validate!
          format_url
        end

        def conn
          headers = {
            "rcp-token" => Utils.encrypted_header(token),
            "app-version" => "RC2"
          }
          RestClient::Resource.new(base_url, headers: headers)
        rescue OpenSSL::Cipher::CipherError => error
          ErrorHandler.new(error, error.class).handle
        end

        def get(endpoint, get_params = {})
          make_request :get, endpoint, params: get_params
        end

        def post(endpoint, post_params)
          make_request :post, endpoint, post_params
        end

        private

        def make_request(method, endpoint, params = {})
          JSON.parse conn[endpoint].public_send(method, params)
        rescue RestClient::ExceptionWithResponse => error
          RcpErrorHandler.new(error).handle
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error, error.class).handle
        end

        def validate!
          validate_url!
          validate_token!
        end

        def format_url
          @base_url << "/" unless base_url.end_with?("/")
        end

        def validate_url!
          raise InvalidCredentialsError.new("invalid_url",
                                            details: [ "#{base_url} is not a valid url" ]) unless Utils.valid_url?(base_url)
        end

        def validate_token!
          raise InvalidCredentialsError.new("token_not_provided",
                                            details: [ "#{token} is not a valid token" ]) unless token.present?
        end

      end
    end
  end
end
