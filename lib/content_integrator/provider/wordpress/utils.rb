module ContentIntegrator
  module Provider
    module Wordpress
      module Utils

        def self.statuses
          [ "publish", "schedule", "draft" ]
        end

        def self.encrypted_header(token)
          TokenEncryptor.new(token).call
        end

        def self.valid_url?(url)
          uri = URI.parse(url)
          return uri.kind_of?(URI::HTTP) || uri.kind_of?(URI::HTTPS)
        rescue URI::InvalidURIError
          false
        end

      end
    end
  end
end
