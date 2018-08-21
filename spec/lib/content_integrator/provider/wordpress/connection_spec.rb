require "spec_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Connection do
  describe "#conn" do
    context "with valid url and token present", vcr: { cassette_name: "content_integrator/wordpress/users/success" } do
      it "includes rcp-token in headers" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        requester = ContentIntegrator::Provider::Wordpress::Connection.new(credential)
        request = requester.conn

        expect(request.headers).to have_key("rcp-token")
      end
    end

    context "with invalid url and token present" do
      it "raises InvalidCredentials error" do
        credential = ContentIntegrator::Credential.new({
          url: "localhost",
          token: "e7c2dcf906fcd9f567c03f0920ddc82a",
        })
        expect { ContentIntegrator::Provider::Wordpress::Connection.new(credential) }.
          to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with valid url and token empty" do
      it "raises InvalidCredentials error" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: nil,
        })
        expect { ContentIntegrator::Provider::Wordpress::Connection.new(credential) }.
          to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end

  describe "#get" do
    context "with valid url and token present", vcr: { cassette_name: "content_integrator/wordpress/users/success" } do
      it "returns a array including users details" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        connection = ContentIntegrator::Provider::Wordpress::Connection.new(credential)
        endpoint   = "?rcp-list-users"
        response   = connection.get(endpoint)

        expected = {
          "user_id"=>4,
          "display_name"=>"raff",
          "email"=>"raff@rockcontent.com",
          "roles"=>[ "subscriber" ]
        }

        expect(response).to include(expected)
      end
    end

    context "with invalid response", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_response" } do
      it "returns a array including users details" do
        credential = ContentIntegrator::Credential.new({
          url: "http://www.rockcontent.com",
          token: "e7c2dcf906fcd9f567c03f0920ddc82a",
        })
        connection = ContentIntegrator::Provider::Wordpress::Connection.new(credential)
        endpoint   = "?rcp-list-users"

        expect { connection.get(endpoint) }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end
end
