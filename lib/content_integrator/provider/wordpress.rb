require "rest_client"

module ContentIntegrator
  module Provider
    module Wordpress

      ENDPOINTS = {
        activate:   "?rcp-activate-plugin",
        disconnect: "?rcp-disconnect-plugin",
        publish:    "?rcp-publish-content",
        users:      "?rcp-list-users",
        categories: "?rcp-list-categories",
        post:       "?rcp-find-post",
      }

    end
  end
end

require_relative "wordpress/token_encryptor"
require_relative "wordpress/utils"
require_relative "wordpress/error_handler"
require_relative "wordpress/rcp_error_handler"
require_relative "wordpress/connection"
require_relative "wordpress/connector"
require_relative "wordpress/disconnector"
require_relative "wordpress/publisher"
require_relative "wordpress/fetcher"
require_relative "wordpress/finder"
require_relative "wordpress/adapter"
