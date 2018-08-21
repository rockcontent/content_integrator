require "spec_helper"
require "support/vcr"
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::OauthHandler do
  let(:valid_token)         { "EAAT7InLGKxIBABZARwe38Kv9cxHkZB2FS0IKcBdZBZC7Itw3zZCXYIZCXbVSoKuqZA7VnDYhDbWnZAdbcApbM5vlURZCNBxzbKxQ6EQ8HdtXjX7u6U42DrINAQF768GYcw0pBP2JJDCSW5CRPnvDHjmZByPqB0xpTLFlmMrKmid5QN7oBees3oreke" }
  let(:valid_client_id)     { "1402025279892242" }
  let(:valid_client_secret) { "b485778c2b36fc9e7f6be32b13f8deac" }

  let(:invalid_token)         { "invalid_token" }
  let(:invalid_client_id)     { "invalid_client_id" }
  let(:invalid_client_secret) { "invalid_client_secret" }

  describe "#refresh_token" do
    context "with all valid credentials", vcr: { cassette_name: "content_integrator/facebook/oauth_handler/refresh_token/success" } do
      it "returns a hash with new token" do
        oauth_handler = ContentIntegrator::Provider::Facebook::OauthHandler.new(
          valid_client_id,
          valid_client_secret
        )

        response = oauth_handler.refresh_token(valid_token)
        expect(response).to eq({
          "access_token"=>"EAAT7InLGKxIBAAhOc3VksOsCGq5q9OlL7SUFkvA16fPGL4lCzzX3ia5cAYOV9tzy17pliTApWxH3TjOZAiDcJ22JWsyKqQ63diDhgkxvABMKrQYGGZCn54ck367XOpfut3So5oIxGGe1ah4lY0OsUZCgI30EB4vKrKWoAuEoAZDZD",
          "token_type"=>"bearer"
        })
      end
    end

    context "with invalid client_id", vcr: { cassette_name: "content_integrator/facebook/oauth_handler/refresh_token/invalid_client_id" } do
      it "raises Koala::Facebook::OAuthTokenRequestError" do
        oauth_handler = ContentIntegrator::Provider::Facebook::OauthHandler.new(
          invalid_client_id,
          valid_client_secret
        )

        expect{
          oauth_handler.refresh_token(valid_token)
        }.to raise_error(
          Koala::Facebook::OAuthTokenRequestError
        )
      end
    end

    context "with invalid client_secret", vcr: { cassette_name: "content_integrator/facebook/oauth_handler/refresh_token/invalid_client_secret" } do
      it "raises exception" do
        oauth_handler = ContentIntegrator::Provider::Facebook::OauthHandler.new(
          valid_client_id,
          invalid_client_secret
        )

        expect{
          oauth_handler.refresh_token(valid_token)
        }.to raise_error(
          Koala::Facebook::OAuthTokenRequestError
        )
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/oauth_handler/refresh_token/invalid_token" } do
      it "raises exception" do
        oauth_handler = ContentIntegrator::Provider::Facebook::OauthHandler.new(
          valid_client_id,
          valid_client_secret
        )

        expect{
          oauth_handler.refresh_token(invalid_token)
        }.to raise_error(
          Koala::Facebook::OAuthTokenRequestError
        )
      end
    end
  end
end
