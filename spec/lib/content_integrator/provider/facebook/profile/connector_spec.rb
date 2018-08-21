require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::Profile::Connector do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/profile/connector/success" } do
      it "has content" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke"
        })
        connector = ContentIntegrator::Provider::Facebook::Profile::Connector.new(credentials)

        response = connector.call

        expected = {
          :name => "Aplicativo RC",
          :pages => [
            {
              :name => "Festa promoções e eventos",
              :id=>"650110601844988",
              :access_token=>"EAAT7InLGKxIBAKqSpBk9sSlnni7GvKmHyKqtfBPLfi7RwjGZBqAL3qXWhRSPtI4Gx3ffz1cBsSjOh1zUTpI9PSy0baGE6HzHuGElFzsrZAYqtwaau0AbMGLN6EZCGyQxCwyvtuhlRfePg3BpDVM5Maqb7zGbmdXxolLWpKWmQRodn30pRJp"
            }
          ],
          :picture_url => "https://scontent.xx.fbcdn.net/v/t1.0-1/c27.0.50.50/p50x50/19060114_103174976960535_7878071916786693101_n.jpg?oh=d66a82197671e7d552bdedf1e2322a69&oe=59D185D7",
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke"
        })
        connector = ContentIntegrator::Provider::Facebook::Profile::Connector.new(credentials)

        response = connector.call

        expected = {
          :token      => "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke",
          :identifier => "112322709379095",
          :secret     => nil,
        }

        expect(response.credentials).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/profile/connector/unsuccess" } do
      it "raises InvalidCredentialsError" do
        credentials = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        })
        connector = ContentIntegrator::Provider::Facebook::Profile::Connector.new(credentials)

        expect { connector.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end
  end
end
