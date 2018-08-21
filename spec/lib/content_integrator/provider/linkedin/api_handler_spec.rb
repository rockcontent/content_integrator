require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::APIHandler do
  let(:valid_token) { "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw" }

  let(:invalid_token) { "invalid_token" }

  describe "#profile" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/profile/success" } do
      it "returns informations about user profile" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)

        profile  = api_handler.profile
        expected = {
          "first_name"                    => "Aplicativo",
          "headline"                      => "Senior Web Application Developer na FAKE",
          "id"                            => "QluzqM654m",
          "last_name"                     => "RC",
          "site_standard_profile_request" => { "url"=>"https://www.linkedin.com/profile/view?id=AAoAACMBINwBfIeBvd7gCPOv2ax-Lm-Yxr8w-z4&authType=name&authToken=RMC1&trk=api*a4460734*s4525754*" },
        }

        expect(profile).to eq(expected)
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/profile/invalid_credentials" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(invalid_token)

        expect {
          api_handler.profile
        }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe "#company" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/company/success" } do
      it "returns informations about company" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)
        company_id  = 22302249 # Recorded on VCR cassete

        company  = api_handler.company(company_id)
        expected = {
          "description" => "Somos uma empresa de Festa.\nFesta o dia inteiro.\nFesta toda hora.",
          "id"          => 22302249,
          "logo_url"    => "https://media.licdn.com/mpr/mpr/AAEAAQAAAAAAAA1mAAAAJGM0YjRiZDUwLTk3Y2UtNDNjYi05ODQ0LTUxYTZmNTJjYjQwMA.png",
          "name"        => "Festa promoções e eventos",
        }

        expect(company).to eq(expected)
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/company/invalid_credentials" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(invalid_token)
        company_id  = 22302249 # Recorded on VCR cassete

        expect {
          api_handler.company(company_id)
        }.to raise_error(Faraday::ClientError)
      end
    end

    context "with invalid company ID", vcr: { cassette_name: "content_integrator/linkedin/api_handler/company/invalid_id" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)
        company_id  = 1

        expect {
          api_handler.company(company_id)
        }.to raise_error(Faraday::ClientError)
      end
    end

    context "with nil company ID", vcr: { cassette_name: "content_integrator/linkedin/api_handler/company/nil_company_id" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)
        company_id  = nil

        expect {
          api_handler.company(company_id)
        }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe "#profile_picture_data" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/profile_picture_data/success" } do
      it "returns informations about profile picture" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)

        response = api_handler.profile_picture_data
        expected = "https://media.licdn.com/mpr/mprx/0_1JVRzpASiQOt0B_1kr6j6Vrm8NGAmR8K3PFjkCAIANYB0c8JAPFZ6WlI3E7ZEUiJcH6j6wrmtymljojrntwNGFKDLymAjolsNtwJBpuSKQ04jgh1N9U4lFGJ6a"

        expect(response).to eq(expected)
      end
    end
    context "with invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/profile_picture_data/invalid_credentials" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(invalid_token)

        expect {
          api_handler.profile_picture_data
        }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe "#get_pages" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/get_pages/success" } do
      it "returns informations about profile pages" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(valid_token)

        response = api_handler.get_pages
        expected = [ { "id"=>22302249, "name"=>"Festa promoções e eventos" } ]

        expect(response).to eq(expected)
      end
    end
    context "with invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/api_handler/get_pages/invalid_credentials" } do
      it "raises a Faraday::ClientError exception" do
        api_handler = ContentIntegrator::Provider::Linkedin::APIHandler.new(invalid_token)

        expect {
          api_handler.get_pages
        }.to raise_error(Faraday::ClientError)
      end
    end
  end
end
