require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::RcpErrorHandler do
  describe "#handle" do
    context "with valid response" do
      context "with invalid credentials error code" do
        it "raises InvalidCredentialsError" do
          body     = '{"error_code": "TK01", "errors": ["Invalid token"]}'
          response = double("response")
          error    = double("error")
          allow(response).to receive(:body).and_return(body)
          allow(error).to receive(:response).and_return(response)

          handler = ContentIntegrator::Provider::Wordpress::RcpErrorHandler.new(error)

          expect {
            handler.handle
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with validation error code" do
        it "raises ValidationError" do
          body     = '{"error_code": "PP01", "errors": ["Post title is required"]}'
          response = double("response")
          error    = double("error")
          allow(response).to receive(:body).and_return(body)
          allow(error).to receive(:response).and_return(response)

          handler = ContentIntegrator::Provider::Wordpress::RcpErrorHandler.new(error)

          expect {
            handler.handle
          }.to raise_error(ContentIntegrator::ValidationError)
        end
      end

      context "with an unknown error" do
        it "raises UnknownError" do
          body     = '{"error_code": "XXXX", "errors": ["UnknownError"]}'
          response = double("response")
          error    = double("error")
          allow(response).to receive(:body).and_return(body)
          allow(error).to receive(:response).and_return(response)

          handler = ContentIntegrator::Provider::Wordpress::RcpErrorHandler.new(error)

          expect {
            handler.handle
          }.to raise_error(ContentIntegrator::UnknownError)
        end
      end
    end

    context "with invalid response" do
      it "raises InvalidResponseError" do
        body     = "Some crazy response"
        response = double("response")
        error    = double("error")
        allow(response).to receive(:body).and_return(body)
        allow(error).to receive(:response).and_return(response)

        handler = ContentIntegrator::Provider::Wordpress::RcpErrorHandler.new(error)

        expect {
          handler.handle
        }.to raise_error(ContentIntegrator::InvalidResponseError)
      end
    end
  end
end
