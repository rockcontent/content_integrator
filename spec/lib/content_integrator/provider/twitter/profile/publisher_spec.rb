require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Twitter::Profile::Publisher do
  let(:valid_token)           { "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c" }
  let(:valid_secret)          { "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF" }
  let(:valid_client_id)       { "aJm6eTORJLqkpCpJZzTBiDCBO" }
  let(:valid_client_secret)   { "OhCUidSqefyLJqkHFigJw8AGpczuU2iNPfXSB14dTf74KfdD4F" }

  let(:invalid_token)         { "invalid" }
  let(:invalid_secret)        { "invalid" }
  let(:invalid_client_id)     { "invalid" }
  let(:invalid_client_secret) { "invalid" }

  describe "#call" do
    context "without image" do
      context "with empty content", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/without_content/unsuccess" }  do
        it "raises ContentIntegrator::ValidationError exception" do
          params = { content: "" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::ValidationError)
        end
      end

      context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/success" } do
        it "has content" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          response = publisher.call

          expected = { :id => 997476429775429632 }

          expect(response.content).to eq(expected)
        end
      end

      context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: invalid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: invalid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: invalid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/publisher/without_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: invalid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end
    end

    context "with image" do
      context "with empty content", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/without_content/success" }  do
        it "has content" do
          params = { content: "", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          response = publisher.call

          expected = { :id => 997476429775429632 }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          params = { content: "", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          response = publisher.call

          expect(response.credentials).to be_empty
        end
      end

      context "with invalid image url", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/success" }  do
        it "raises ContentIntegrator::ValidationError exception" do
          params = { content: "My post", picture: "https://www.w3schools.com/there_are_not_image.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::ValidationError)
        end
      end

      context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/success" } do
        it "has content" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          response = publisher.call

          expected = { :id => 997476417599352833 }

          expect(response.content).to eq(expected)
        end
      end

      context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: invalid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: invalid_secret,
            client_id: valid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: invalid_client_id,
            client_secret: valid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/publisher/with_image/unsuccess" } do
        it "raises ContentIntegrator::InvalidCredentialsError exception" do
          params = { content: "My post", picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg" }
          credential = ContentIntegrator::Credential.new({
            token: valid_token,
            secret: valid_secret,
            client_id: valid_client_id,
            client_secret: invalid_client_secret
          })

          publisher = ContentIntegrator::Provider::Twitter::Profile::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end
    end
  end
end
