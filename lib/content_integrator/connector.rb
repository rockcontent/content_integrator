module ContentIntegrator
  class Connector < Base

    def initialize(provider_name, credentials)
      super(provider_name, credentials)
    end

    def call
      conn.connect
    end

  end
end
