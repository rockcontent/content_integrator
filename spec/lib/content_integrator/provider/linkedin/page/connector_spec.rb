require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::Page::Connector do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/page/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          identifier: 22302249,
        })
        connector = ContentIntegrator::Provider::Linkedin::Page::Connector.new(credential)

        response = connector.call

        expected = {
          :pages => [],
          :name => "Festa promoções e eventos",
          :picture_url => "https://media.licdn.com/mpr/mpr/AAEAAQAAAAAAAA1mAAAAJGM0YjRiZDUwLTk3Y2UtNDNjYi05ODQ0LTUxYTZmNTJjYjQwMA.png"
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          identifier: 22302249,
        })
        connector = ContentIntegrator::Provider::Linkedin::Page::Connector.new(credential)

        response = connector.call

        expected = {
          :token => "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          :identifier => 22302249,
          :secret => nil
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/linkedin/page/connector/invalid_response" } do
      it "raises InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        connector = ContentIntegrator::Provider::Linkedin::Page::Connector.new(credential)

        expect { connector.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end
  end
end
