require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::ErrorHandler do
  describe "#handle" do
    context "handling connection errors" do
      it "raises connection error on OpenSSL SSLError" do
        error   = OpenSSL::SSL::SSLError.new("Error")
        handler = ContentIntegrator::Provider::Wordpress::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end

      it "raises connection error on OpenSSL CipherError" do
        error = OpenSSL::Cipher::CipherError.new("Error")
        handler = ContentIntegrator::Provider::Wordpress::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "handling connection errors" do
      it "raises InvalidResponseError on JSON ParserError" do
        error = JSON::ParserError.new("Error")
        handler = ContentIntegrator::Provider::Wordpress::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end

end
