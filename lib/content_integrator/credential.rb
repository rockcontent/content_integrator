module ContentIntegrator
  class Credential
    attr_reader :token,
                :refresh_token,
                :secret,
                :client_id,
                :client_secret,
                :url,
                :identifier

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
