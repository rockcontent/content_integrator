module ContentIntegrator
  class Base

    def initialize(provider_name, credentials)
      @provider_name = provider_name.to_sym
      @credentials   = credentials
    end

    protected

    attr_reader :provider_name, :credentials

    def conn
      provider.new(credentials)
    rescue TypeError, NameError
      raise InvalidProviderError.new(
        "invalid_provider", details: [ "#{provider_name} is an invalid provider" ]
      )
    end

    def provider
      providers_list = ContentIntegrator.providers
      ContentIntegrator.const_get(providers_list[provider_name])
    end

  end
end
