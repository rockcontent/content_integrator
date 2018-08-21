require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Fetcher do
  context "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/users/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        endpoint = "?rcp-list-users"
        fetcher  = ContentIntegrator::Provider::Wordpress::Fetcher.new(credential, endpoint)

        response = fetcher.call

        expected = [ { :id=>"1", :name=>"produto" }, { :id=>"4", :name=>"raff" } ]

        expect(response.content).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_token" } do
      it "raises InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        endpoint = "?rcp-list-users"
        fetcher  = ContentIntegrator::Provider::Wordpress::Fetcher.new(credential, endpoint)

        expect { fetcher.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid url" do
      it "raises InvalidCredentialsError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "111-.wrong-address.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        endpoint = "?rcp-list-users"

        expect { ContentIntegrator::Provider::Wordpress::Fetcher.new(credential, endpoint) }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid response", vcr: { cassette_name: "content_integrator/wordpress/users/invalid_response" } do
      it "raises InvalidResponseError exception" do
        credential = ContentIntegrator::Credential.new({
          url: "http://www.rockcontent.com",
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        endpoint = "?rcp-list-users"
        fetcher  = ContentIntegrator::Provider::Wordpress::Fetcher.new(credential, endpoint)

        expect { fetcher.call }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end
end
