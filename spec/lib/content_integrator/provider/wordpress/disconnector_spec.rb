require "spec_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Disconnector do
  describe ".call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/disconnector/success" } do
      it "has content with disconnect date" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        disconnector = ContentIntegrator::Provider::Wordpress::Disconnector.new(credential)

        response = disconnector.call

        expected = {
          "disconnected_at" => "2017-08-02 16:19:43",
        }

        expect(response.content).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_token" } do
      it "raises InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        disconnector = ContentIntegrator::Provider::Wordpress::Disconnector.new(credential)

        expect { disconnector.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid url" do
      it "raises InvalidCredentialsError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "111-.wrong-address.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })

        expect { ContentIntegrator::Provider::Wordpress::Disconnector.new(credential) }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid response", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_response" } do
      it "raises InvalidResponseError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "https://rockcontent.com/",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        disconnector = ContentIntegrator::Provider::Wordpress::Disconnector.new(credential)

        expect { disconnector.call }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end
end
