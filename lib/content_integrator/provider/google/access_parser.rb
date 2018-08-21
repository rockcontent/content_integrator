module ContentIntegrator
  module Provider
    module Google
      class AccessParser

        EMPTY_TITLE = "(not set)"

        def initialize(access, posts)
          @access = access
          @posts = posts
          @post = find_post
        end

        def parse
          post ? update_post_title : create_post
        end

        private

        attr_reader :access, :posts, :post

        def find_post
          posts.find { |post| post[:url] == url }
        end

        def update_post_title
          title_not_set? ? post.merge!(title: title) : post
        end

        def create_post
          posts << { url: url, title: title, accesses: [] }
          posts.last
        end

        def title_not_set?
          title != EMPTY_TITLE
        end

        def url
          URI(URI.escape(access.pagePath)).path
        end

        def title
          access.pageTitle
        end

      end
    end
  end
end
