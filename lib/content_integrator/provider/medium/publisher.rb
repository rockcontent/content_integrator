module ContentIntegrator
  module Provider
    module Medium

      class ArticleBuilder

        def initialize(params)
          @params = params
        end

        def build
          [ image_tag, title_tag, article ].join
        end

        private

        attr_reader :params

        def image_tag
          "<img src='#{ image }' />" if image.present?
        end

        def image
          params[:image]
        end

        def title_tag
          "<h1>#{ params[:title] }</h1>"
        end

        def article
          params[:article]
        end

      end

      class Publisher

        attr_reader :credential, :params

        def initialize(credential, params)
          @params     = params
          @credential = credential
        end

        def call
          response = client.post_publication(format_params)["data"]
          response["publicationData"] = publication_data
          Response.new(content: response)
        end

        private

        def client
          Client.new(access_token: token,
                     resource_id: publication)
        end

        def token
          credential.token
        end

        def publication_data
          user_client.publications["data"].select{ |pub| pub["id"] == publication }.first
        end

        def user_client
          Client.new(access_token: token,
                     resource_id: credential.identifier)
        end

        def publication
          params[:category]
        end

        def format_params
          case
          when params[:tags].present?
            params_with_tags
          else
            post_params
          end
        end

        def params_with_tags
          post_params.merge!(tags: post_tags)
        end

        def post_tags
          params[:tags].split(",").map(&:strip)
        end

        def post_params
          {
            title: params[:title],
            contentFormat: "html",
            content: ArticleBuilder.new(params).build,
            publishStatus: status,
          }
        end

        def status
          case params[:status]
          when "publish"
            "public"
          when "draft"
            "draft"
          end
        end

      end
    end
  end
end
