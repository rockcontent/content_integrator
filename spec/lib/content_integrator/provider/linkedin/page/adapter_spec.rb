require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::Page::Adapter do
  describe "#connect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/page/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          identifier: 22302249,
        })
        adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

        response = adapter.connect

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
        adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

        response = adapter.connect

        expected = {
          :token => "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          :identifier => 22302249,
          :secret => nil
        }

        expect(response.credentials).to eq(expected)
      end
    end
  end

  describe "#publish" do
    context "with valid credentials" do
      context "post with image", vcr: { cassette_name: "content_integrator/linkedin/page/publisher/with_image/success" } do
        let(:params) do
          {
            link: "https://rockcontent.com",
            picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            content: "My post",
          }
        end

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            token: "AQX-AX0x3XWHjNsV0fEu7nP6hkdmmo4iKXdUt7GyHE1yTm1CkEZrR2eOmrMl2ojZFaSvnbbADM2_A7O0oNDN_ZpjKwgU_YjrYbp6fYykupHB7sTFacohAzf3v-ZIVvaUwBruAgpBiw_FIUQF9ior7qHUP0VrRSDBCmReWZZ06V7GrBmNm7NFlN7ApgiptJ7uiIzLsSX7GoQSrugrNZobWvSs5WNsHHsxKjQwXCB9IAU5mADmHomFhGZ_lIAjeexS-oEBhNFVmIQv8tmSLhjlT-4X3FiJXP0we_HJTVLptqgs0-ehTu3hlnEtnZpQRQOpOVKVLSAIFl2eAszyaCVGQg9CCngJIA",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          response = adapter.publish(params)

          expected = {
            updateKey: "UPDATE-c22302249-6402979133294407680",
            updateUrl: "https://www.linkedin.com/company/22302249/comments?topic=6402979133294407680&type=U&scope=22302249&stype=C&a=jSN_",
          }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          credential = ContentIntegrator::Credential.new({
            token: "AQX-AX0x3XWHjNsV0fEu7nP6hkdmmo4iKXdUt7GyHE1yTm1CkEZrR2eOmrMl2ojZFaSvnbbADM2_A7O0oNDN_ZpjKwgU_YjrYbp6fYykupHB7sTFacohAzf3v-ZIVvaUwBruAgpBiw_FIUQF9ior7qHUP0VrRSDBCmReWZZ06V7GrBmNm7NFlN7ApgiptJ7uiIzLsSX7GoQSrugrNZobWvSs5WNsHHsxKjQwXCB9IAU5mADmHomFhGZ_lIAjeexS-oEBhNFVmIQv8tmSLhjlT-4X3FiJXP0we_HJTVLptqgs0-ehTu3hlnEtnZpQRQOpOVKVLSAIFl2eAszyaCVGQg9CCngJIA",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          response = adapter.publish(params)

          expect(response.credentials).to be_empty
        end
      end

      context "post without image", vcr: { cassette_name: "content_integrator/linkedin/page/publisher/without_image/success" } do
        let(:params) { { content: "My post" } }

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            token: "AQX-AX0x3XWHjNsV0fEu7nP6hkdmmo4iKXdUt7GyHE1yTm1CkEZrR2eOmrMl2ojZFaSvnbbADM2_A7O0oNDN_ZpjKwgU_YjrYbp6fYykupHB7sTFacohAzf3v-ZIVvaUwBruAgpBiw_FIUQF9ior7qHUP0VrRSDBCmReWZZ06V7GrBmNm7NFlN7ApgiptJ7uiIzLsSX7GoQSrugrNZobWvSs5WNsHHsxKjQwXCB9IAU5mADmHomFhGZ_lIAjeexS-oEBhNFVmIQv8tmSLhjlT-4X3FiJXP0we_HJTVLptqgs0-ehTu3hlnEtnZpQRQOpOVKVLSAIFl2eAszyaCVGQg9CCngJIA",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          response = adapter.publish(params)

          expected = {
            updateKey: "UPDATE-c22302249-6402979129758613504",
            updateUrl: "https://www.linkedin.com/company/22302249/comments?topic=6402979129758613504&type=U&scope=22302249&stype=C&a=NTFP",
          }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          credential = ContentIntegrator::Credential.new({
            token: "AQX-AX0x3XWHjNsV0fEu7nP6hkdmmo4iKXdUt7GyHE1yTm1CkEZrR2eOmrMl2ojZFaSvnbbADM2_A7O0oNDN_ZpjKwgU_YjrYbp6fYykupHB7sTFacohAzf3v-ZIVvaUwBruAgpBiw_FIUQF9ior7qHUP0VrRSDBCmReWZZ06V7GrBmNm7NFlN7ApgiptJ7uiIzLsSX7GoQSrugrNZobWvSs5WNsHHsxKjQwXCB9IAU5mADmHomFhGZ_lIAjeexS-oEBhNFVmIQv8tmSLhjlT-4X3FiJXP0we_HJTVLptqgs0-ehTu3hlnEtnZpQRQOpOVKVLSAIFl2eAszyaCVGQg9CCngJIA",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          response = adapter.publish(params)

          expect(response.credentials).to be_empty
        end
      end
    end

    context "wiht invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/page/publisher/invalid_token" } do
      context "post with image" do
        let(:params) do
          {
            link: "https://rockcontent.com",
            picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            content: "My post",
          }
        end

        it "raises ConnectionError" do
          credential = ContentIntegrator::Credential.new({
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          expect { adapter.publish(params) }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end

      context "post without image" do
        let(:params) { { content: "My post" } }

        it "raises ConnectionError" do
          credential = ContentIntegrator::Credential.new({
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            identifier: 22302249,
          })
          adapter = ContentIntegrator::Provider::Linkedin::Page::Adapter.new(credential)

          expect { adapter.publish(params) }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end
  end
end
