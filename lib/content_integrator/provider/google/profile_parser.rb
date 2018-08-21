module ContentIntegrator
  module Provider
    module Google
      class ProfileParser
        def initialize(profile)
          @profile = profile
        end

        def parse
          {
            id: profile.id,
            name: "#{ profile.web_property.name } - #{ profile.name }",
            website_url: profile.attributes["websiteUrl"],
          }
        end

        private

        attr_reader :profile
      end
    end
  end
end
