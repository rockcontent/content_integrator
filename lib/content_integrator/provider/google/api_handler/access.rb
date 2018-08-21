module ContentIntegrator
  module Provider
    module Google
      class APIHandler
        class Access
          extend Legato::Model

          SORT = "-sessions"
          LIMIT = 10000

          metrics :sessions
          dimensions :medium, :page_path, :page_title

          def self.daily_sessions(profile, date)
            results(profile, start_date: date, end_date: date, sort: SORT,
              limit: LIMIT).to_a
          end
        end
      end
    end
  end
end
