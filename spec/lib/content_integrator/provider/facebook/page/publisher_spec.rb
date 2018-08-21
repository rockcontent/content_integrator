require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::Page::Publisher do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/page/publisher/success" } do
      let(:credentials) do
        ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK"
        })
      end

      let(:params) { { picture: "https://www.w3schools.com/css/paris.jpg", content: "My post" } }

      it "has content" do
        publisher = ContentIntegrator::Provider::Facebook::Page::Publisher.new(credentials, params)

        response = publisher.call

        expected = {
          :id               => "656721211183927",
          :post_id          => "650110601844988_656721211183927",
          :publication_type => "picture",
        }

        expect(response.content).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/page/publisher/invalid_token" } do
      let(:credentials) do
        ContentIntegrator::Credential.new({ token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" })
      end
      let(:params) { { picture: "https://www.w3schools.com/css/paris.jpg", content: "My post" } }

      it "raises InvalidCredentialsError" do
        publisher = ContentIntegrator::Provider::Facebook::Page::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid picture_url on params", vcr: { cassette_name: "content_integrator/facebook/page/publisher/invalid_picture" } do
      let(:credentials) do
        ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK"
        })
      end
      let(:params) { { picture: "http://www.example.com/there_are_not_image_here.jpg", content: "My post" } }

      it "raises ConnectionError" do
        publisher = ContentIntegrator::Provider::Facebook::Page::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "with invalid link on params", vcr: { cassette_name: "content_integrator/facebook/page/publisher/invalid_link" } do
      let(:credentials) do
        ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK"
        })
      end
      let(:params) { { link: "invalid link", content: "My post" } }

      it "raises ConnectionError" do
        publisher = ContentIntegrator::Provider::Facebook::Page::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end
  end
end
