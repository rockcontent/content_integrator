module ContentIntegrator
  module Provider
    module Linkedin

      COMPANY_FIELDS = [ "id", "name", "description", "logo-url" ]

      class APIHandler
        def initialize(token, handler = LinkedIn::API)
          @handler = handler.new(token)
        end

        def profile
          @profile ||= handler.profile
        end

        def company(id)
          @company ||= handler.company(id: id, fields: COMPANY_FIELDS)
        end

        def profile_picture_data
          @profile_picture_data ||= begin
                                      pictures = handler.picture_urls.all
                                      if pictures
                                        pictures.first
                                      else
                                        ""
                                      end
                                    end
        end

        def get_pages
          @get_pages ||= Array(handler.company({ is_admin: "true" }).all)
        end

        def add_company_share(company_id:, options: {})
          handler.add_company_share(company_id, options)
        end

        def add_share(options: {})
          handler.add_share(options)
        end

        private

        attr_reader :handler
      end
    end
  end
end
