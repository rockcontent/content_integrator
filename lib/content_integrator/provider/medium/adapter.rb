module ContentIntegrator
  module Provider
    module Medium
      class Adapter

        attr_reader :credential

        def initialize(credential)
          @credential = credential
        end

        def connect
          Medium::Connector.new(credential).call
        end

        def publish(params)
          Medium::Publisher.new(credential, params).call
        end

        def publications
          Medium::Fetcher.new(credential).call
        end

        def disconnect
        end

      end
    end
  end
end
