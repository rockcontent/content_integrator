module ContentIntegrator
  module Provider
    module Wordpress
      class Adapter

        attr_reader :credential

        def initialize(credential)
          @credential = credential
        end

        def connect
          Connector.new(credential).call
        end

        def disconnect
          Disconnector.new(credential).call
        end

        def publish(params)
          Publisher.new(credential, params).call
        end

        def users
          Fetcher.new(credential, ENDPOINTS[:users]).call
        end

        def categories
          Fetcher.new(credential, ENDPOINTS[:categories]).call
        end

        def find_post(post_id)
          Finder.new(credential, ENDPOINTS[:post], post_id).call
        end

      end
    end
  end
end
