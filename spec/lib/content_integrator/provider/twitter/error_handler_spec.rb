require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Twitter::ErrorHandler do
  describe "#handle" do
    context "handling connection errors" do
      it "raises connection error on Twitter Bad Request" do
        error   = ::Twitter::Error::BadRequest.new("bad_request")
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end

      it "raises connection error on Twitter Configuration Error" do
        error   = ::Twitter::Error::ConfigurationError.new("configuration_error")
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "handling invalid credentials errors" do
      it "raises InvalidCredentialsError on Twitter Unauthorized" do
        error   = ::Twitter::Error::Unauthorized.new("unauthorized")
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "handling invalid validation errors" do
      it "raises ValidationError on Twitter Forbidden" do
        error   = ::Twitter::Error::Forbidden.new("forbidden")
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ValidationError)
      end

      it "raises ValidationError on Twitter DuplicateStatus" do
        error   = ::Twitter::Error::DuplicateStatus.new("duplicate_status")
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ValidationError)
      end

      it "raises ValidationError on Twitter UnacceptableIO" do
        error   = ::Twitter::Error::UnacceptableIO.new
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ValidationError)
      end

      it "raises ValidationError on OpenURI HTTPError" do
        error   = ::OpenURI::HTTPError.new("picture_url not found", nil)
        handler = ContentIntegrator::Provider::Twitter::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ValidationError)
      end
    end
  end
end
