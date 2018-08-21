module ContentIntegrator
  class Disconnector < Base

    def initialize(provider_name, credentials)
      super(provider_name, credentials)
    end

    def call
      conn.disconnect
    end

  end
end
