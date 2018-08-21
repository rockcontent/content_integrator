require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Google::OauthHandler do
  describe "#profiles" do
    context "with credentials and a handler" do
      it "returns a refreshed token" do
        refresh_token = double
        handler = double(new: double)
        token_handler = double(new: double(refresh!: refresh_token))

        credentials = ContentIntegrator::Credential.new(client_id: "token",
          client_secret: "secret")
        adapter = ContentIntegrator::Provider::Google::OauthHandler.new(credentials,
          handler: handler, token_handler: token_handler)
        response = adapter.call

        expect(response).to be(refresh_token)
      end
    end
  end
end
