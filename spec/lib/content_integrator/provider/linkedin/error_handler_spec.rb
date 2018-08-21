require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Linkedin::ErrorHandler do
  describe "#handle" do
    context "handling connection errors" do
      it "raises ConnectionError on Faraday Client Error" do
        error   = Faraday::ClientError.new("linkedin client error")
        handler = ContentIntegrator::Provider::Linkedin::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "handling invalid credentials errors" do
      it "raises InvalidCredentialsError error with Invalid Credentials" do
        error   = LinkedIn::InvalidRequest.new("linkedin client error")
        handler = ContentIntegrator::Provider::Linkedin::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end
end
