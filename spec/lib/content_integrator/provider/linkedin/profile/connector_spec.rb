require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::Profile::Connector do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/profile/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
        })
        connector = ContentIntegrator::Provider::Linkedin::Profile::Connector.new(credential)

        response = connector.call

        expected = {
          :name => "Aplicativo RC",
          :pages => [ { :name=>"Festa promoções e eventos", :id=>22302249 } ],
          :picture_url => "https://media.licdn.com/mpr/mprx/0_1JVRzpASiQOt0B_1kr6j6Vrm8NGAmR8K3PFjkCAIANYB0c8JAPFZ6WlI3E7ZEUiJcH6j6wrmtymljojrntwNGFKDLymAjolsNtwJBpuSKQ04jgh1N9U4lFGJ6a"
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
        })
        connector = ContentIntegrator::Provider::Linkedin::Profile::Connector.new(credential)

        response = connector.call

        expected = {
          :token => "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          :identifier => "QluzqM654m",
          :secret => nil
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/linkedin/profile/connector/invalid_response" } do
      it "raises InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        })
        connector = ContentIntegrator::Provider::Linkedin::Profile::Connector.new(credential)

        expect { connector.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end
  end
end
