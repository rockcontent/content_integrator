require "linkedin-oauth2"

module ContentIntegrator
  module Provider
    module Linkedin
    end
  end
end

require_relative "linkedin/error_handler"
require_relative "linkedin/api_handler"
require_relative "linkedin/base_connector"
require_relative "linkedin/base_publisher"
require_relative "linkedin/page/adapter"
require_relative "linkedin/page/connector"
require_relative "linkedin/page/publisher"
require_relative "linkedin/profile/adapter"
require_relative "linkedin/profile/connector"
require_relative "linkedin/profile/publisher"
