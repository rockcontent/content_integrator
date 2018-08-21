require "koala"

module ContentIntegrator
  module Provider
    module Facebook
    end
  end
end

require_relative "facebook/error_handler"
require_relative "facebook/api_handler"
require_relative "facebook/oauth_handler"
require_relative "facebook/token_exchanger"
require_relative "facebook/base_publisher"
require_relative "facebook/base_connector"
require_relative "facebook/page/adapter"
require_relative "facebook/page/connector"
require_relative "facebook/page/publisher"
require_relative "facebook/profile/adapter"
require_relative "facebook/profile/connector"
require_relative "facebook/profile/publisher"
