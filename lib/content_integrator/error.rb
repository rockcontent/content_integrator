module ContentIntegrator

  class Error < StandardError

    attr_reader :details

    def initialize(msg = "", details:)
      @details = details
      super(msg)
    end

  end

  InvalidProviderError    = Class.new(Error)
  InvalidCredentialsError = Class.new(Error)
  InvalidResponseError    = Class.new(Error)
  ConnectionError         = Class.new(Error)
  ValidationError         = Class.new(Error)
  UnknownError            = Class.new(Error)
  ForbiddenError          = Class.new(Error)

end
