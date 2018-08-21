require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::Page::Connector do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/page/connector/success" } do
      it "has content" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK"
        })
        connector = ContentIntegrator::Provider::Facebook::Page::Connector.new(credentials)

        response = connector.call

        expected = {
          :pages       => [],
          :name        => "Festa promoções e eventos",
          :picture_url => "https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/19029295_650110748511640_3810536270875623326_n.png?oh=2d707e1640c2d0d32f88028e6791e6c5&oe=59E0D276",
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK"
        })
        connector = ContentIntegrator::Provider::Facebook::Page::Connector.new(credentials)

        response = connector.call

        expected = {
          :token      => "EAAT7InLGKxIBAPUZBz3nqUCjzI7AUrsZAU3Ys1dRUZB3QEVwE4zv77ZBJOJ1jek9U7S90EMiDOmbGJq1qvum7IZBTD7nY1sv2lX1YJyRgTypnexLyXSxa5SW6O7roWebOXypvHmmAwHfCnsKfaiElq7yeJZCXvlQC5Fw70RLOJvEwH2HFILGmK",
          :identifier => "650110601844988",
          :secret     => nil,
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/page/connector/unsuccess" } do
      it "raises InvalidCredentialError" do
        credentials = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        })
        connector = ContentIntegrator::Provider::Facebook::Page::Connector.new(credentials)

        expect { connector.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

  end
end
