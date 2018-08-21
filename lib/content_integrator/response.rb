module ContentIntegrator
  class Response

    attr_reader :content, :credentials

    def initialize(content:, credentials: {})
      @content     = content
      @credentials = credentials
    end

    def to_json
      {
        content: content,
        credentials: credentials
      }
    end

  end
end
