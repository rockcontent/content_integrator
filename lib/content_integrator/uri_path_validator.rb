require "uri"

module ContentIntegrator
  class UriPathValidator
    def initialize(uri)
      @uri = uri.to_s
    end

    def valid?
      !URI(URI.escape(uri)).path.empty?
    rescue URI::InvalidURIError
      false
    end

    private

    attr_reader :uri
  end
end
