require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::Profile::Publisher do
  describe "#call" do
    context "with valid credentials" do
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
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          response = publisher.call

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
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          response = publisher.call

          expected = {
            updateKey: "UPDATE-587276508-6278622978804633600",
            updateUrl: "https://www.linkedin.com/updates?discuss=&scope=587276508&stype=M&topic=6278622978804633600&type=U&a=gwwg",
          }

          expect(response.credentials).to be_empty
        end
      end

      context "post without image", vcr: { cassette_name: "content_integrator/linkedin/profile/publisher/without_image/success" } do
        let(:params) { { content: "My post" } }

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            token: "AQUTbsX08lw9jpB0Bh3Rbyc2xsMpS8o6U6nG24ureQOFsumDUqAFcUqd_rUNo3_AURj7xZ-uKdLSqLbGaz_RaKs1uTDZyacIl1cAcVL9wQZ_PF9vgKcMTMISOHaOshEzvdcEvqkNDiuqjVz-3-GHJIUfuRSxPxG2EHuMiwLRaWav2p7DXENnlVIHtJOAA-JTFFIFUjwVXR_2mFGkanvqAsgym5G3E6BEmc7IcNT0f6e8jJIVL1944Y-U_WdzojvCVDss77JFIKWDsY45W2MqY_jz8mHYSkvrHXSsFKC4dIzTubIcahwayRfAmGFKtxnyvywSJtnQ0C237hy_c0S4vjTl-ql5Eg",
          })
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          response = publisher.call

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
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          response = publisher.call

          expected = {
            updateKey: "UPDATE-587276508-6278622978804633600",
            updateUrl: "https://www.linkedin.com/updates?discuss=&scope=587276508&stype=M&topic=6278622978804633600&type=U&a=gwwg",
          }

          expect(response.credentials).to be_empty
        end
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/linkedin/profile/publisher/invalid_token" } do
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
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end

      context "post without image" do
        let(:params) { { content: "My post" } }

        it "raises ConnectionError" do
          credential = ContentIntegrator::Credential.new({
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          })
          publisher = ContentIntegrator::Provider::Linkedin::Profile::Publisher.new(credential, params)

          expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end
  end
end
