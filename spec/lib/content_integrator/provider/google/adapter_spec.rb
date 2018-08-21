require "rails_helper"
require "spec_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Google::Adapter do

  describe "#connect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/google/adapter/success" } do
      it "returns a profile list" do
        credentials = ContentIntegrator::Credential.new(token: "token",
          refresh_token: "refresh_token", client_id: "id", client_secret: "secret",
          identifier: {})
        adapter = ContentIntegrator::Provider::Google::Adapter.new(credentials)

        response = adapter.profiles

        expect(response).to include({
          id: "222222222",
          name: "Exemplo - Todos os dados do website",
          website_url: "http://example.com/"
        })
      end
    end

    context "with invalid client_id and secret", vcr: { cassette_name: "content_integrator/google/adapter/client_error" } do
      it "raises invalid client ConnectionError " do
        credentials = ContentIntegrator::Credential.new(
          token: "valid_token",
          refresh_token: "valid_token",
          client_id: "invalid_id",
          client_secret: "invalid_secret",
          identifier: {}
        )
        adapter = ContentIntegrator::Provider::Google::Adapter.new(credentials)

        expect {
          adapter.profiles
        }.to raise_error do |error|
          expect(error).to be_a(ContentIntegrator::ConnectionError)
          expect(error.message).to eq("invalid_client")
          expect(error.details).to eq("The OAuth client was not found.")
        end
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/google/adapter/token_error" } do
      it "raises invalid grant ConnectionError" do
        credentials = ContentIntegrator::Credential.new(
          token: "invalid_token",
          refresh_token: "invalid_token",
          client_id: "valid_id",
          client_secret: "valid_secret",
          identifier: {}
        )
        adapter = ContentIntegrator::Provider::Google::Adapter.new(credentials)

        expect {
          adapter.connect
          adapter.profiles
        }.to raise_error { |error|
          expect(error).to be_a(ContentIntegrator::ConnectionError)
          expect(error.message).to eq("invalid_grant")
          expect(error.details).to be_empty
        }
      end
    end

    context "with invalid google analytics account", vcr: { cassette_name: "content_integrator/google/adapter/invalid_account" } do
      it "raises invalid grant ConnectionError" do
        credentials = ContentIntegrator::Credential.new(
          token: "valid_token",
          refresh_token: "valid_token",
          client_id: "valid_id",
          client_secret: "valid_secret",
          identifier: {}
        )
        adapter = ContentIntegrator::Provider::Google::Adapter.new(credentials)

        expect {
          adapter.connect
          adapter.profiles
        }.to raise_error { |error|
          expect(error).to be_a(ContentIntegrator::ValidationError)
          expect(error.message).to eq("invalid_account")
          expect(error.details).to eq("User does not have any Google Analytics account.")
        }
      end
    end
  end
end
