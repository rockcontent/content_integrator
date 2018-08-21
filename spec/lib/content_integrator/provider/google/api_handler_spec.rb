require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Google::APIHandler do
  describe "#profiles" do
    context "with credentials and a handler" do
      it "returns a parsed profile collection" do
        oauth_handler = double(new: double(call: double))
        handler = double(new:
          double(profiles: [
            double(
              id: 1,
              name: "Profile",
              web_property: double(name: "Site"),
              attributes: { "websiteUrl" => "site" },
            )
          ])
        )
        credentials = ContentIntegrator::Credential.new( client_id: "token", client_secret: "secret" )
        adapter = ContentIntegrator::Provider::Google::APIHandler.new(credentials,
          handler: handler, oauth_handler: oauth_handler)

        response = adapter.profiles

        expect(response).to match_array([
          { id: 1, name: "Site - Profile", website_url: "site" },
        ])
      end
    end
  end
end
