require "rails_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Medium::Publisher do
  describe "#call" do
    context "with valid params", vcr: { cassette_name: "content_integrator/medium/publisher/success" } do
      it "returns post title in response" do
        params     = {
          title: "My Article",
          article: "My Article Body",
          status: "draft",
          category: "d3595794a6af",
          image: "http://produtoteste.rockcontent.com/wp-content/uploads/2017/09/119944-o-que-faz-um-agente-autonomo-de-investimento.jpg",
        }
        credential = ContentIntegrator::Credential.new({
          token: "228761677d72c2bdd1be4589288d242599942105626131bac40d4849c38963505",
          identifier: "14f9b6301c7fe1bc69c5a3d1adb47d7a71074c24733748328aec34591e4fc8f84"
        })

        publisher = described_class.new(credential, params)
        response  = publisher.call

        expect(response.content["title"]).to eq("My Article")
      end
    end

    context "with invalid credentials", vcr: { cassette_name: "content_integrator/medium/publisher/invalid_token" } do
      it "raises invalidCredentialsError" do
        params     = {
          title: "My Article",
          article: "My Article Body",
          status: "draft",
          category: "d3595794a6af",
          image: "http://produtoteste.rockcontent.com/wp-content/uploads/2017/09/119944-o-que-faz-um-agente-autonomo-de-investimento.jpg",
        }
        credential = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaa",
          identifier: "aaaaaaaaaaaaaaaaaa"
        })

        publisher = described_class.new(credential, params)

        expect {
          publisher.call
        }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end
end
