require "spec_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::TokenExchanger do
  let(:valid_token)         { "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke" }
  let(:valid_client_id)     { "1402025279892242" }
  let(:valid_client_secret) { "b485778c2b36fc9e7f6be32b13f8deac" }

  let(:invalid_token)         { "invalid_token" }
  let(:invalid_client_id)     { "invalid_client_id" }
  let(:invalid_client_secret) { "invalid_client_secret" }

  describe "#call" do
    context "with all valid credentials", vcr: { cassette_name: "content_integrator/facebook/token_exchanger/success" } do
      it "returns complete response" do
        credential  = ContentIntegrator::Credential.new({
          token: valid_token,
          client_id: valid_client_id,
          client_secret: valid_client_secret,
        })

        exchanger = ContentIntegrator::Provider::Facebook::TokenExchanger.new(
          credential,
          valid_token
        ).call

        expected = {
          expires: nil,
          token: "EAAT7InLGKxIBAG2cYsSWVwfZCZBo7UVAFdmM4BZAqYntZAN99mJQGQBZCjxRX6hOevdLAqrIdCR2NxVcEE8qBPJCAbfQZBHFsfITyigbidxAKPriNSd51orJtRs5JApIGIFIZBT36HJZARQOnDIuWNhUzkbSx4KppZCkZD",
        }

        expect(exchanger.content).to eq(expected)
      end
    end

    context "with invalid credential" do
      context "with invalid client_id", vcr: { cassette_name: "content_integrator/facebook/token_exchanger/invalid_client_id" }  do
        it "raises exception" do
          credential  = ContentIntegrator::Credential.new({
            client_id: invalid_client_id,
            client_secret: valid_client_secret,
          })

          exchanger = ContentIntegrator::Provider::Facebook::TokenExchanger.new(
            credential,
            valid_token
          )

          expect{
            exchanger.call
          }.to raise_error(StandardError)
        end
      end

      context "with invalid client secret", vcr: { cassette_name: "content_integrator/facebook/token_exchanger/invalid_client_secret" }  do
        it "raises expeption" do
          credential  = ContentIntegrator::Credential.new({
            client_id: valid_client_id,
            client_secret: invalid_client_secret,
          })

          exchanger = ContentIntegrator::Provider::Facebook::TokenExchanger.new(
            credential,
            valid_token
          )

          expect{
            exchanger.call
          }.to raise_error(ContentIntegrator::ConnectionError)
        end
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/token_exchanger/invalid_token" } do
      it "raises exception" do
        credential  = ContentIntegrator::Credential.new({
            client_id: valid_client_id,
            client_secret: valid_client_secret,
          })

          exchanger = ContentIntegrator::Provider::Facebook::TokenExchanger.new(
            credential,
            invalid_token
          )

          expect{
            exchanger.call
          }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end
  end
end
