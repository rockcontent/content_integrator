require "oauth2"
require "legato"
require "uri"
require "rack-timeout"

module ContentIntegrator
  module Provider
    module Google
    end
  end
end

require_relative "google/error_handler"
require_relative "google/profile_parser"
require_relative "google/api_handler/access"
require_relative "google/api_handler"
require_relative "google/oauth_handler"
require_relative "google/access_parser"
require_relative "google/access_fetcher"
require_relative "google/connector"
require_relative "google/adapter"
