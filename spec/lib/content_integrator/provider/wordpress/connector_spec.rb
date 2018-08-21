require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Connector do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        connector = ContentIntegrator::Provider::Wordpress::Connector.new(credential)

        response = connector.call

        expected = {
          "activated_at" => "2017-08-02 17:05:59",
          "php_version" => "5.6.31",
          "rcp_version" => "2.0.0",
          "redirect_path" => "http://produtoteste.rockcontent.com/wp-admin/admin.php?page=rcp_plugin_options&integrated=success",
          "wordpress_version" => "4.8",
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        connector = ContentIntegrator::Provider::Wordpress::Connector.new(credential)

        response = connector.call

        expected = {
          "url" => "http://produtoteste.rockcontent.com",
          "token" => "d266c97b552de1dc502415f3d7d70ac3",
        }

        expect(response.credentials).to eq(expected)
      end

    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_token" } do
      it "raises InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        connector = ContentIntegrator::Provider::Wordpress::Connector.new(credential)

        expect { connector.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid url" do
      it "raises InvalidCredentialsError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "111-.wrong-address.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        expect { ContentIntegrator::Provider::Wordpress::Connector.new(credential) }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid response", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_response" } do
      it "raises InvalidResponseError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "http://www.rockcontent.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        connector = ContentIntegrator::Provider::Wordpress::Connector.new(credential)

        expect { connector.call }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end
end

