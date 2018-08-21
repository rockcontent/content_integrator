module ContentIntegrator
  class Publisher < Base

    def initialize(provider_name, credentials, params)
      super(provider_name, credentials)
      @params = params
    end

    def call
      conn.publish(params)
    end

    private

    attr_reader :params

  end
end
