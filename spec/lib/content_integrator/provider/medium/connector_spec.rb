require "rails_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Medium::Connector do
  describe "#call" do
    context "with valid code", vcr: { cassette_name: "content_integrator/medium/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: "e886345ab4f8"
        })

        connector = ContentIntegrator::Provider::Medium::Connector.new(credential)

        response = connector.call

        expected = { :picture_url=>"https://cdn-images-1.medium.com/fit/c/400/400/0*-zg-vLTt5zv_prXj.", :name=>"Hugo Dias", :username=>"hugo.dias" }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          token: "e886345ab4f8"
        })

        connector = ContentIntegrator::Provider::Medium::Connector.new(credential)

        response = connector.call

        expected = {
          :identifier=>"14f9b6301c7fe1bc69c5a3d1adb47d7a71074c24733748328aec34591e4fc8f84",
          :token=>"27e15adc32c0a512207053646d60ea99be89f8a7d43fae11b475a33ba1460c68e",
          :secret=>"2bda995f6e2ceb90710700eebf1ce9fb2bd08c03bcefc82eac5997c91c170d683",
          :url=>"https://medium.com/@hugo.dias"
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid code", vcr: { cassette_name: "content_integrator/medium/connector/invalid_code" } do
      it "raises InvalidCredentialError" do
        credential = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaa"
        })

        connector = ContentIntegrator::Provider::Medium::Connector.new(credential)

        expect {
          connector.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end
end
