require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Twitter::Profile::Connector do
  let(:valid_token)           { "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c" }
  let(:valid_secret)          { "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF" }
  let(:valid_client_id)       { "aJm6eTORJLqkpCpJZzTBiDCBO" }
  let(:valid_client_secret)   { "OhCUidSqefyLJqkHFigJw8AGpczuU2iNPfXSB14dTf74KfdD4F" }

  let(:invalid_token)         { "invalid" }
  let(:invalid_secret)        { "invalid" }
  let(:invalid_client_id)     { "invalid" }
  let(:invalid_client_secret) { "invalid" }

  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: valid_secret,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        response = connector.call

        expected = {
          :name => "Aplicativo RC",
          :pages => [],
          :picture_url => "http://pbs.twimg.com/profile_images/871759165215166468/xiSUqwRD_normal.jpg",
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: valid_secret,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        response = connector.call

        expected = {
          :token => "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c",
          :identifier => 871757613222047744,
          :secret => "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF",
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/connector/invalid_token" } do
      it "raises ContentIntegrator::InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: invalid_token,
          secret: valid_secret,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        expect {
          connector.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/connector/invalid_secret" } do
      it "raises ContentIntegrator::InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: invalid_secret,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        expect {
          connector.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/connector/invalid_client_id" } do
      it "raises ContentIntegrator::InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: valid_secret,
          client_id: invalid_client_id,
          client_secret: valid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        expect {
          connector.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid invalid_client_secret", vcr: { cassette_name: "content_integrator/twitter/connector/invalid_client_secret" } do
      it "raises ContentIntegrator::InvalidCredentialsError" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: valid_secret,
          client_id: valid_client_id,
          client_secret: invalid_client_secret,
        })

        connector = ContentIntegrator::Provider::Twitter::Profile::Connector.new(credential)

        expect {
          connector.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end
end
