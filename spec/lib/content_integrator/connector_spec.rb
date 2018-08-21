require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Connector do
  describe "#call" do
    context "when provider does not exists" do
      it "raises invalid provider exception" do
        connector = ContentIntegrator::Connector.new("fake_adapter", {})

        expect { connector.call }.to raise_error(ContentIntegrator::InvalidProviderError)
      end
    end

    context "when provider exists" do
      context "sucessefully connected" do
        module ContentIntegrator
          register_provider :connector_success, "ConnectorSuccessAdapter"

          class ConnectorSuccessAdapter
            def initialize(credentials) end

            def connect
              Response.new(content: { data: "ok" }, credentials: { token: "123" })
            end
          end
        end

        it "has content" do
          connector = ContentIntegrator::Connector.new("connector_success", {})

          response = connector.call

          expect(response.content).to eq({ data: "ok" })
        end

        it "has credentials" do
          connector = ContentIntegrator::Connector.new("connector_success", {})

          response = connector.call

          expect(response.credentials).to eq({ token: "123" })
        end
      end

      context "unsucessefully connected" do
        module ContentIntegrator
          register_provider :connector_unsuccess, "ConnectorUnsuccessAdapter"

          class ConnectorUnsuccessAdapter
            def initialize(credentials)
            end

            def connect
              raise ConnectionError.new("not_found", details: [
                "URL not found"
              ])
            end
          end
        end

        it "raise a connection exception" do
          connector = ContentIntegrator::Connector.new("connector_unsuccess", {})

          expect { connector.call }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end
  end
end
