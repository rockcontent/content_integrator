require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Publisher do
  describe "#call" do
    context "when provider does not exists" do
      it "raises invalid provider exception" do
        params      = { title: "Post title", description: "Post description" }
        credentials = { token: "123" }
        publisher   = ContentIntegrator::Publisher.new("fake_adapter", credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::InvalidProviderError)
      end
    end

    context "when provider exists" do
      context "sucessefully published" do
        module ContentIntegrator
          register_provider :publisher_success, "PublisherSuccessAdapter"

          class PublisherSuccessAdapter
            def initialize(credentials)
            end

            def publish(_params)
              Response.new(content: { data: "ok" })
            end
          end
        end

        it "has content" do
          params      = { title: "Post title", description: "Post description" }
          credentials = { token: "123" }
          publisher   = ContentIntegrator::Publisher.new("publisher_success", credentials, params)

          response = publisher.call

          expect(response.content).to eq({ data: "ok" })
        end
      end

      context "unsucessefully published" do
        module ContentIntegrator
          register_provider :publisher_unsuccess, "PublisherUnsuccessAdapter"

          class PublisherUnsuccessAdapter
            def initialize(credentials)
            end

            def publish(_params)
              raise InvalidResponseError.new("", details: [
                "URL not found"
              ])
            end
          end
        end

        it "raise a connection exception" do
          params      = { title: "Post title", description: "Post description" }
          credentials = { token: "123" }
          publisher   = ContentIntegrator::Publisher.new("publisher_unsuccess", credentials, params)

          expect { publisher.call }.to raise_error(ContentIntegrator::InvalidResponseError)
        end
      end
    end
  end
end
