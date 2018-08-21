require "twitter"

module ContentIntegrator
  module Provider
    module Twitter
    end
  end
end

require_relative "twitter/error_handler"
require_relative "twitter/api_handler"
require_relative "twitter/profile/adapter"
require_relative "twitter/profile/base"
require_relative "twitter/profile/connector"
require_relative "twitter/profile/publisher"
