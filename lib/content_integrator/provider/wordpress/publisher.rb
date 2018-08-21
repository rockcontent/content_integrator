module ContentIntegrator
  module Provider
    module Wordpress
      class Publisher

        attr_reader :connection, :response, :params

        def initialize(credential, params)
          @connection = Connection.new(credential).conn
          @params     = params
        end

        def call
          @response = request(ENDPOINTS[:publish])
          build_response
        end

        private

        def build_response
          Response.new(content: response)
        end

        def request(endpoint)
          JSON.parse connection[endpoint].post(post_params)
        rescue RestClient::ExceptionWithResponse => error
          RcpErrorHandler.new(error).handle
        rescue *RESCUABLE_ERRORS => error
          ErrorHandler.new(error, error.class).handle
        end

        def post_params
          {
            data: {
              post_status:    params[:status],
              post_content:   params[:article],
              post_title:     params[:title],
              post_author:    params[:author],
              post_category:  params[:category],
              featured_image: params[:image],
              post_tags:      params[:tags],
              post_name:      params[:slug],
            }
          }
        end

      end
    end
  end
end
