require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Twitter::Profile::Adapter do
  let(:valid_token)           { "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c" }
  let(:valid_secret)          { "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF" }
  let(:valid_client_id)       { "aJm6eTORJLqkpCpJZzTBiDCBO" }
  let(:valid_client_secret)   { "OhCUidSqefyLJqkHFigJw8AGpczuU2iNPfXSB14dTf74KfdD4F" }

  describe "#connect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: valid_token,
          secret: valid_secret,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })
        connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

        response = connector.connect

        expected = {
          :pages => [],
          :name => "Aplicativo RC",
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
        connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

        response = connector.connect

        expected = {
          :token => "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c",
          :identifier => 871757613222047744,
          :secret => "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF",
        }

        expect(response.credentials).to eq(expected)
      end
    end
  end

  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/success" }  do
      context "with image" do
        it "has content" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret,
          })
          connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

          response = connector.publish(params)

          expected = { :id => 997476417599352833 }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret,
          })
          connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

          response = connector.publish(params)

          expect(response.credentials).to be_empty
        end
      end

      context "without image", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/success" } do
        it "has content" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret,
          })

          connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

          response = connector.publish(params)

          expected = { :id => 997476429775429632 }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret,
          })

          connector = ContentIntegrator::Provider::Twitter::Profile::Adapter.new(credential)

          response = connector.publish(params)

          expect(response.credentials).to be_empty
        end
      end
    end
  end
end
