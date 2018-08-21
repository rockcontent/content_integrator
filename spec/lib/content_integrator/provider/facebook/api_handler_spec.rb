require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::APIHandler do
  let(:valid_token) { "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke" }

  let(:invalid_token) { "invalid_token" }

  describe "#get_pages" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/get_pages/success" } do
      it "returns informations about user's page" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)

        response = api_handler.get_pages

        expect(response).not_to be_empty
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/get_pages/invalid_credentials" } do
      it "raises a Koala::Facebook::AuthenticationError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(invalid_token)

        expect {
          api_handler.get_pages
        }.to raise_error(Koala::Facebook::AuthenticationError)
      end
    end
  end

  describe "#account_object" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/account_object/success" } do
      it "returns informations about user's account" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)

        response = api_handler.account_object

        expect(response).not_to be_empty
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/account_object/invalid_credentials" } do
      it "raises a Koala::Facebook::AuthenticationError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(invalid_token)

        expect {
          api_handler.account_object
        }.to raise_error(Koala::Facebook::AuthenticationError)
      end
    end
  end

  describe "#picture_data" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/picture_data/success" } do
      it "returns informations about user's picture" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)

        response = api_handler.picture_data

        expect(response).not_to be_empty
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/picture_data/invalid_credentials" } do
      it "raises a Koala::Facebook::AuthenticationError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(invalid_token)

        expect {
          api_handler.picture_data
        }.to raise_error(Koala::Facebook::AuthenticationError)
      end
    end
  end

  describe "#put_wall_post" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_wall_post/success" } do
      it "returns informations about published post" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)
        link        = "http://www.example.com/"
        content     = "My post"

        response = api_handler.put_wall_post(content, link)

        expect(response).not_to be_empty
      end
    end

    context "with invalid link", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_wall_post/invalid_link" } do
      it "raises a Koala::Facebook::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)
        link        = "invalid link"
        content     = "My post"

        expect {
          api_handler.put_wall_post(content, link)
        }.to raise_error(Koala::Facebook::ClientError)
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_wall_post/invalid_credentials" } do
      it "raises a Koala::Facebook::AuthenticationError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(invalid_token)
        link        = "http://www.example.com/"
        content     = "My post"

        expect {
          api_handler.put_wall_post(content, link)
        }.to raise_error(Koala::Facebook::AuthenticationError)
      end
    end
  end

  describe "#put_picture" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_picture/success" } do
      it "returns informations about published post" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)
        picture_url = "https://www.w3schools.com/css/paris.jpg"
        content     = "My post"

        response = api_handler.put_picture(picture_url, content)

        expect(response).not_to be_empty
      end
    end
    context "with invalid picture url", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_picture/invalid_picture" } do
      it "raises a Koala::Facebook::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(valid_token)
        picture_url = "http://www.example.com/there_are_not_image_here.jpg"
        content     = "My post"

        expect {
          api_handler.put_picture(picture_url, content)
        }.to raise_error(Koala::Facebook::ClientError)
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/facebook/api_handler/put_picture/invalid_credentials" } do
      it "raises a Koala::Facebook::AuthenticationError exception" do
        api_handler = ContentIntegrator::Provider::Facebook::APIHandler.new(invalid_token)
        picture_url = "http://www.example.com/thumbnail.jpg"
        content     = "My post"

        expect {
          api_handler.put_picture(picture_url, content)
        }.to raise_error(Koala::Facebook::AuthenticationError)
      end
    end
  end
end

