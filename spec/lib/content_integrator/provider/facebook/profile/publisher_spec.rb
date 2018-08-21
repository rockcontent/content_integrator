require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Facebook::Profile::Publisher do
  describe "#call" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/facebook/profile/publisher/success" } do
      let(:params) { { picture: "https://www.w3schools.com/css/paris.jpg", content: "My post" } }

      it "has content" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAbIwmK788cBACBFrhlRsNvcm3HfCrRmZC8PThuseZB0pDL9zJ5IVPyKvQ8ize65jKVqnFX0iZCZBD4hAmqVCHrrvKU3tzKrZCtXocewjRZCg34V0AQ7NOIM9VxSi8JXv8GHMonbZCcrxTxS39ZCNCj3EVabMTdb637tNdiz25kmPAZDZD"
        })
        publisher = ContentIntegrator::Provider::Facebook::Profile::Publisher.new(credentials, params)

        response = publisher.call

        expected = {
          :id               => "204493813495317",
          :post_id          => "143874036223962_204426923502006",
          :publication_type => "picture"
        }

        expect(response.content).to eq(expected)
      end
    end

    context "with invalid token", vcr: { cassette_name: "content_integrator/facebook/profile/publisher/invalid_token" } do
      let(:params) { { picture: "https://www.w3schools.com/css/paris.jpg", content: "My post" } }

      it "raises InvalidCredentialsError" do
        credentials = ContentIntegrator::Credential.new({
          token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        })
        publisher = ContentIntegrator::Provider::Facebook::Profile::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::InvalidCredentialsError)
      end
    end

    context "with invalid picture_url on params", vcr: { cassette_name: "content_integrator/facebook/profile/publisher/invalid_picture" } do
      let(:params) { { picture: "http://www.example.com/there_are_not_image_here.jpg", content: "My post" } }

      it "raises ConnectionError" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAbIwmK788cBACBFrhlRsNvcm3HfCrRmZC8PThuseZB0pDL9zJ5IVPyKvQ8ize65jKVqnFX0iZCZBD4hAmqVCHrrvKU3tzKrZCtXocewjRZCg34V0AQ7NOIM9VxSi8JXv8GHMonbZCcrxTxS39ZCNCj3EVabMTdb637tNdiz25kmPAZDZD"
        })
        publisher = ContentIntegrator::Provider::Facebook::Profile::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end

    context "with invalid link on params", vcr: { cassette_name: "content_integrator/facebook/profile/publisher/invalid_link" } do
      let(:params) { { link: "invalid link", content: "My post" } }

      it "raises ConnectionError" do
        credentials = ContentIntegrator::Credential.new({
          token: "EAAbIwmK788cBACBFrhlRsNvcm3HfCrRmZC8PThuseZB0pDL9zJ5IVPyKvQ8ize65jKVqnFX0iZCZBD4hAmqVCHrrvKU3tzKrZCtXocewjRZCg34V0AQ7NOIM9VxSi8JXv8GHMonbZCcrxTxS39ZCNCj3EVabMTdb637tNdiz25kmPAZDZD"
        })
        publisher = ContentIntegrator::Provider::Facebook::Profile::Publisher.new(credentials, params)

        expect { publisher.call }.to raise_error(ContentIntegrator::ConnectionError)
      end
    end
  end
end
