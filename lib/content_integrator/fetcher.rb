module ContentIntegrator
  class Fetcher < Base

    AVAILABLE_RESOURCES = %w(users categories profiles accesses publications)

    def initialize(provider_name, credentials, resource, options = {})
      super(provider_name, credentials)
      raise NotImplementedError unless AVAILABLE_RESOURCES.include?(resource)
      @resource = resource
      @options = options
    end

    def call
      conn.public_send(*params)
    end

    private

    def params
      return [ resource ] if options.empty?
      [ resource, options ]
    end

    attr_reader :resource, :options

  end
end
