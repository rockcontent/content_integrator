module ContentIntegrator
  class PostFinder < Base

    def initialize(provider_name, credentials, post_id)
      super(provider_name, credentials)
      @post_id = post_id
    end

    def call
      conn.find_post(post_id)
    end

    private

    attr_reader :post_id

  end
end
