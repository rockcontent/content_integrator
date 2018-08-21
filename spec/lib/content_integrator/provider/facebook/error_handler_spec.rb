require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::ErrorHandler do
  describe "#handle" do
    context "handling connection errors" do
      it "raises connection error on Facebook Client" do
        error = Koala::Facebook::ClientError.new(400, "facebook client error")
        handler = ContentIntegrator::Provider::Facebook::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end

      it "raises connection error on Facebook Server" do
        error = Koala::Facebook::ServerError.new(500, "facebook client error")
        handler = ContentIntegrator::Provider::Facebook::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end

      it "raises connection error on Bad Facebook Response" do
        error = Koala::Facebook::BadFacebookResponse.new(400, "facebook client error")
        handler = ContentIntegrator::Provider::Facebook::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end

      it "raises connection error on OAuth Token Request" do
        error = Koala::Facebook::OAuthTokenRequestError.new(400, "facebook client error")
        handler = ContentIntegrator::Provider::Facebook::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "handling invalid credentials errors" do
      it "raises InvalidCredentialsError on Faceebook Authentication" do
        error = Koala::Facebook::AuthenticationError.new(401, "Facebook authentication error")
        handler = ContentIntegrator::Provider::Facebook::ErrorHandler.new(error)

        expect { handler.handle }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end

end

