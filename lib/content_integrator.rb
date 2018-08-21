require "content_integrator/version"
require "open-uri"

module ContentIntegrator
  class << self

    attr_reader :providers

    def register_provider(name, klass)
      @providers = {} unless providers
      providers[name] = klass
    end

  end

  CMS_PROVIDERS = %w(wordpress medium)

  register_provider :google, "Provider::Google::Adapter"
  register_provider :wordpress, "Provider::Wordpress::Adapter"
  register_provider :medium, "Provider::Medium::Adapter"
  register_provider :facebook_page, "Provider::Facebook::Page::Adapter"
  register_provider :facebook_profile, "Provider::Facebook::Profile::Adapter"
  register_provider :linkedin_page, "Provider::Linkedin::Page::Adapter"
  register_provider :linkedin_profile, "Provider::Linkedin::Profile::Adapter"
  register_provider :twitter_profile, "Provider::Twitter::Profile::Adapter"
end

require_relative "content_integrator/utils"
require_relative "content_integrator/error"
require_relative "content_integrator/response"
require_relative "content_integrator/credential"
require_relative "content_integrator/provider/wordpress"
require_relative "content_integrator/provider/medium"
require_relative "content_integrator/provider/facebook"
require_relative "content_integrator/provider/linkedin"
require_relative "content_integrator/provider/twitter"
require_relative "content_integrator/provider/google"
require_relative "content_integrator/base"
require_relative "content_integrator/connector"
require_relative "content_integrator/disconnector"
require_relative "content_integrator/publisher"
require_relative "content_integrator/fetcher"
require_relative "content_integrator/post_finder"
require_relative "content_integrator/uri_path_validator"
