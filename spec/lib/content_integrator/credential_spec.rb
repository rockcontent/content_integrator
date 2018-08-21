require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Credential do
  describe "#token" do
    context "when setted" do
      it "returns token" do
        options = { token: "aaaaaaaaaaa" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.token).to eq(options[:token])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.token).to be_nil
      end
    end
  end
  describe "#secret" do
    context "when setted" do
      it "returns secret" do
        options = { secret: "$IU*$*(Y4Y89DSY892Y8D" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.secret).to eq(options[:secret])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.secret).to be_nil
      end
    end
  end
  describe "#client_id" do
    context "when setted" do
      it "returns client_id" do
        options = { client_id: "232131" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.client_id).to eq(options[:client_id])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.client_id).to be_nil
      end
    end
  end
  describe "#client_secret" do
    context "when setted" do
      it "returns client_secret" do
        options = { client_secret: "3213232321dsds" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.client_secret).to eq(options[:client_secret])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.client_secret).to be_nil
      end
    end
  end
  describe "#url" do
    context "when setted" do
      it "returns url" do
        options = { url: "$IU*$*(Y4Y89DSY892Y8D" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.url).to eq(options[:url])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.url).to be_nil
      end
    end
  end
  describe "#identifier" do
    context "when setted" do
      it "returns identifier" do
        options = { identifier: "$IU*$*(Y4Y89DSY892Y8D" }
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.identifier).to eq(options[:identifier])
      end
    end
    context "when did not set" do
      it "returns nil" do
        options = {}
        credential = ContentIntegrator::Credential.new(options)

        expect(credential.identifier).to be_nil
      end
    end
  end
end
