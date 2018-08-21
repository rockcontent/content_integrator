require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Twitter::APIHandler do
  let(:valid_token)           { "871757613222047744-LuERkhfXKoJynkNDzZY4EI3Qg50YV6c" }
  let(:valid_secret)          { "7wvgvI4emtP89SmiaZELcMzxJhZgcxYiBvwn8oeJ27HRF" }
  let(:valid_client_id)       { "aJm6eTORJLqkpCpJZzTBiDCBO" }
  let(:valid_client_secret)   { "OhCUidSqefyLJqkHFigJw8AGpczuU2iNPfXSB14dTf74KfdD4F" }

  let(:invalid_token)         { "invalid" }
  let(:invalid_secret)        { "invalid" }
  let(:invalid_client_id)     { "invalid" }
  let(:invalid_client_secret) { "invalid" }

  describe "#account_id" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/success" } do
      it "returns informations about user's id" do
        api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                           valid_secret,
                                                                           valid_client_id,
                                                                           valid_client_secret)

        response = api_handler.account_id
        expected = 871757613222047744

        expect(response).to eq(expected)
      end
    end

    context "with invalid credentials" do
      context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(invalid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_id
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             invalid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_id
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             invalid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_id
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             invalid_client_secret)

          expect {
            api_handler.account_id
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end
    end
  end

  describe "#account_name" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/success" } do
      it "returns informations about user's account" do
        api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                           valid_secret,
                                                                           valid_client_id,
                                                                           valid_client_secret)

        response = api_handler.account_name
        expected = "Aplicativo RC"

        expect(response).to eq(expected)
      end
    end

    context "with invalid credentials" do
      context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(invalid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_name
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             invalid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_name
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             invalid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.account_name
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             invalid_client_secret)

          expect {
            api_handler.account_name
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end
    end
  end

  describe "#picture_data" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/success" } do
      it "returns informations about user's picture" do
        api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                           valid_secret,
                                                                           valid_client_id,
                                                                           valid_client_secret)

        response = api_handler.picture_data
        expected = "http://pbs.twimg.com/profile_images/871759165215166468/xiSUqwRD_normal.jpg"

        expect(response).to eq(expected)
      end
    end

    context "with invalid credentials" do
      context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(invalid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.picture_data
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             invalid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.picture_data
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             invalid_client_id,
                                                                             valid_client_secret)

          expect {
            api_handler.picture_data
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end

      context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/profile/unsuccess" } do
        it "raises a Twitter::Error::Unauthorized exception" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             invalid_client_secret)

          expect {
            api_handler.picture_data
          }.to raise_error(::Twitter::Error::Unauthorized)
        end
      end
    end
  end

  describe "#post" do
    context "with picture_url present" do
      context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_with_image/success" } do
        it "returns informations about post" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)
          content = "My post"
          picture_url = "https://www.w3schools.com/css/paris.jpg"

          response = api_handler.post(content, picture_url)
          expected = ::Twitter::Tweet.new(id: 997475811438530560)

          expect(response).to eq(expected)
        end
      end

      context "with invalid credentials" do
        context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_with_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(invalid_token,
                                                                               valid_secret,
                                                                               valid_client_id,
                                                                               valid_client_secret)
            content     = "My post"
            picture_url = "https://www.w3schools.com/css/paris.jpg"

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_with_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                               invalid_secret,
                                                                               valid_client_id,
                                                                               valid_client_secret)
            content     = "My post"
            picture_url = "https://www.w3schools.com/css/paris.jpg"

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_with_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                               valid_secret,
                                                                               invalid_client_id,
                                                                               valid_client_secret)
            content     = "My post"
            picture_url = "https://www.w3schools.com/css/paris.jpg"

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_with_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                               valid_secret,
                                                                               valid_client_id,
                                                                               invalid_client_secret)
            content     = "My post"
            picture_url = "https://www.w3schools.com/css/paris.jpg"

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end
      end
    end

    context "with picture_url empty" do
      context "with valid credentials", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_without_image/success" } do
        it "returns informations about post" do
          api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                             valid_secret,
                                                                             valid_client_id,
                                                                             valid_client_secret)
          content     = "My post"
          picture_url = ""

          response = api_handler.post(content, picture_url)
          expected = ::Twitter::Tweet.new(id: 997475796544520192)

          expect(response).to eq(expected)
        end
      end

      context "with invalid credentials" do
        context "with invalid token", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_without_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(invalid_token,
                                                                               valid_secret,
                                                                               valid_client_id,
                                                                               valid_client_secret)
            content     = "My post"
            picture_url = ""

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_without_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                               invalid_secret,
                                                                               valid_client_id,
                                                                               valid_client_secret)
            content     = "My post"
            picture_url = ""

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid client_id", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_without_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                              valid_secret,
                                                                              invalid_client_id,
                                                                              valid_client_secret)
            content     = "My post"
            picture_url = ""

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end

        context "with invalid client_secret", vcr: { cassette_name: "content_integrator/twitter/api_handler/post_without_image/unsuccess" } do
          it "raises a Twitter::Error::Unauthorized exception" do
            api_handler = ContentIntegrator::Provider::Twitter::APIHandler.new(valid_token,
                                                                              valid_secret,
                                                                              valid_client_id,
                                                                              invalid_client_secret)
            content     = "My post"
            picture_url = ""

            expect {
              api_handler.post(content, picture_url)
            }.to raise_error(::Twitter::Error::Unauthorized)
          end
        end
      end
    end
  end
end
