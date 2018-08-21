require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::TokenEncryptor do
  describe ".call" do
    context "with a 32 characters token" do
      it "returns an encrypted token" do
        token     = "e7c2dcf906fcd9f567c03f0920ddc82a"
        timestamp = 1495462513.8865962

        encryptor = ContentIntegrator::Provider::Wordpress::TokenEncryptor.new(token, timestamp: timestamp)

        expect(encryptor.call).to eq("z1Q1VKChuljMa9GIN8gGUNR_NRCyiY5ky5oeoFkl2cyUHPc8/ey3/JaGbNOs/Ccw")
      end
    end

    context "with an invalid token" do
      it "raises ArgumentError exception" do
        token = "123"
        timestamp = 1495462513.8865962

        expect {
          ContentIntegrator::Provider::Wordpress::TokenEncryptor.new(token, timestamp: timestamp)
        }.to raise_error(OpenSSL::Cipher::CipherError)
      end
    end
  end
end
