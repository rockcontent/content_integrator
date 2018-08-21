require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Google::Connector do
  describe "#call" do
    context "with credentials and a handler" do

      it "returns a response object" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        credentials = ContentIntegrator::Credential.new(token: "token", identifier: {})
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.class).to eq(ContentIntegrator::Response)
      end

      it "response has content with name" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        name = "Name"
        credentials = ContentIntegrator::Credential.new(token: "token",
          identifier: { "name" => name })
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.content).to include(name: name)
      end

      it "response has content with email" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        email = "me@example.com"
        credentials = ContentIntegrator::Credential.new(token: "token",
          identifier: { "email" => email })
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.content).to include(email: email)
      end

      it "response has content with picture_url" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        image = "http://example.com/img.jpg"
        credentials = ContentIntegrator::Credential.new(token: "token",
          identifier: { "image" => image })
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.content).to include(picture_url: image)
      end

      it "response has a credential with a token" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        credentials = ContentIntegrator::Credential.new(token: "token", identifier: {})
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.credentials).to include(token: "token")
      end

      it "response has a credential with a refresh token" do
        profile_list = double
        handler = double("APIHandler", new: double(profiles: profile_list))
        credentials = ContentIntegrator::Credential.new(refresh_token: "refresh_token",
          identifier: {})
        connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
          handler: handler)

        response = connector.call

        expect(response.credentials).to include(refresh_token: "refresh_token")
      end
    end
  end

  describe "#profiles" do
    it "returns profiles" do
      profile_list = double
      handler = double("APIHandler", new: double(profiles: profile_list))
      credentials = ContentIntegrator::Credential.new(token: "token", identifier: {})
      connector = ContentIntegrator::Provider::Google::Connector.new(credentials,
        handler: handler)

      response = connector.profiles

      expect(response).to be(profile_list)
    end
  end
end
