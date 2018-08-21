require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::Profile::Adapter do
  describe "#connect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/linkedin/profile/connector/success" } do
      let(:credentials) {
        {
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw"
        }
      }

      it "has content" do
        credential = ContentIntegrator::Credential.new({
          token: "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
        })
        connector = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

        response = connector.connect

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
        connector = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

        response = connector.connect

        expected = {
          :token => "AQVMYAwQRTiYnneCk-k8V5JURAKqipJh2yvco8jJU6fktRlrCg_qjxcVg1QfrknrIPhpiSqSYdMaYoVr8y9I4vOaecGBHVV-1YIMSEWtLqz9op6tj39jlVij-xLTOk8HjyHq-Jf6-wC7a6MTYMibe_FM-FHeYrqHkiYM_1myJ45ItDpLafw",
          :identifier => "QluzqM654m",
          :secret => nil
        }

        expect(response.credentials).to eq(expected)
      end
    end
  end

  describe "#publish" do
    context "with valid credentAQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Egials" do
      let(:credentials) do
        {
          token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg"
        }
      end

      context "post with image", vcr: { cassette_name: "content_integrator/linkedin/profile/publisher/with_image/success" } do
        let(:params) do
          {
            link: "https://rockcontent.com",
            picture: "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg",
            content: "My post",
          }
        end

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg",
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          response = adapter.publish(params)

          expected = {
            updateKey: "UPDATE-319248707-6402981718801813504",
            updateUrl: "https://www.linkedin.com/updates?discuss=&scope=319248707&stype=M&topic=6402981718801813504&type=U&a=C9xP",
          }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          credential = ContentIntegrator::Credential.new({
            token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg",
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          response = adapter.publish(params)

          expect(response.credentials).to be_empty
        end
      end

      context "post without image", vcr: { cassette_name: "content_integrator/linkedin/profile/publisher/without_image/success" } do
        let(:params) { { content: "My post" } }

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg",
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          response = adapter.publish(params)

          expected = {
            updateKey: "UPDATE-319248707-6402981977514868736",
            updateUrl: "https://www.linkedin.com/updates?discuss=&scope=319248707&stype=M&topic=6402981977514868736&type=U&a=yPCI",
          }

          expect(response.content).to eq(expected)
        end

        it "does not have credentials" do
          credential = ContentIntegrator::Credential.new({
            token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg",
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          response = adapter.publish(params)

          expect(response.credentials).to be_empty
        end
      end
    end

    context "wiht invalid credentials", vcr: { cassette_name: "content_integrator/linkedin/profile/publisher/invalid_token" } do
      let(:credentials) { { token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" } }

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
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          expect { adapter.publish(params) }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end

      context "post without image" do
        let(:params) { { content: "My post" } }

        it "raises ConnectionError" do
          credential = ContentIntegrator::Credential.new({
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          })
          adapter = ContentIntegrator::Provider::Linkedin::Profile::Adapter.new(credential)

          expect { adapter.publish(params) }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end
  end
end
