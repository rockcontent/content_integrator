module ContentIntegrator
  module Provider
    module Google
      class APIHandler
        def initialize(credentials, oauth_handler: OauthHandler, handler: Legato::User)
          @credentials = credentials
          @oauth_handler = oauth_handler
          @handler = handler
        end

        def profiles
          user.profiles.map { |profile| ProfileParser.new(profile).parse }
        end

        def accesses(date)
          Access.daily_sessions(profile, date)
        end

        private

        attr_reader :credentials, :oauth_handler, :handler

        def user
          handler.new(access_token)
        end

        def access_token
          oauth_handler.new(credentials).call
        end

        def profile
          user.profiles.find do |profile|
            profile.id == credentials.identifier
          end
        end
      end
    end
  end
end
