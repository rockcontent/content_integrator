require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Disconnector do
  describe "#call" do
    context "when provider does not exists" do
      it "raises invalid provider exception" do
        disconnector = ContentIntegrator::Disconnector.new("fake_adapter", {})

        expect { disconnector.call }.to raise_error(ContentIntegrator::InvalidProviderError)
      end
    end

    context "when provider exists" do
      context "sucessefully connected" do
        module ContentIntegrator
          register_provider :disconnector_success, "DisconnectorSuccessAdapter"

          class DisconnectorSuccessAdapter
            def initialize(credentials) end

            def disconnect
              Response.new(content: { data: "ok" }, credentials: { token: "123" })
            end
          end
        end

        it "has content" do
          disconnector = ContentIntegrator::Disconnector.new("disconnector_success", {})

          response = disconnector.call

          expect(response.content).to eq({ data: "ok" })
        end

        it "has credentials" do
          disconnector = ContentIntegrator::Disconnector.new("disconnector_success", {})

          response = disconnector.call

          expect(response.credentials).to eq({ token: "123" })
        end
      end

      context "unsucessefully connected" do
        module ContentIntegrator
          register_provider :disconnector_unsuccess, "DisconnectorUnsuccessAdapter"

          class DisconnectorUnsuccessAdapter
            def initialize(credentials)
            end

            def disconnect
              raise ConnectionError.new("not_found", details: [
                "URL not found"
              ])
            end
          end
        end

        it "raise a connection exception" do
          disconnector = ContentIntegrator::Disconnector.new("disconnector_unsuccess", {})

          expect { disconnector.call }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end
  end
end
