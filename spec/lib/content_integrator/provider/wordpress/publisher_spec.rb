require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Publisher do
  describe "#call" do
    context "with valid credentials" do

      context "with valid params", vcr: { cassette_name: "content_integrator/wordpress/publisher/success" } do
        let(:params) {
          {
            status: "draft",
            title: "My awesome post",
            article: "My awesome article",
            image: "http://produtoteste.rockcontent.com/wp-content/uploads/2017/09/119944-o-que-faz-um-agente-autonomo-de-investimento.jpg"
          }
        }

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            url: "http://produtoteste.rockcontent.com",
            token: "d266c97b552de1dc502415f3d7d70ac3",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Publisher.new(credential, params)

          response = publisher.call
          expected = {
            "author" => "0",
            "comment_count" => "0",
            "comment_status" => "open",
            "featured_image" => "http://produtoteste.rockcontent.com/wp-content/uploads/2017/09/119944-o-que-faz-um-agente-autonomo-de-investimento-1.jpg",
            "filter" => "raw",
            "link" => "http://produtoteste.rockcontent.com/?p=148",
            "guid" => "http://produtoteste.rockcontent.com/?p=148",
            "menu_order" => 0,
            "ping_status" => "open",
            "pinged" => "",
            "post_content" => "My awesome article",
            "post_content_filtered" => "",
            "post_date" => "2017-09-27 17:53:30",
            "post_date_gmt" => "0000-00-00 00:00:00",
            "post_excerpt" => "",
            "post_id" => 148,
            "post_mime_type" => "",
            "post_modified" => "2017-09-27 17:53:30",
            "post_modified_gmt" => "0000-00-00 00:00:00",
            "post_name" => "",
            "post_parent" => 0,
            "post_password" => "",
            "post_status" => "draft",
            "post_title" => "My awesome post",
            "post_type" => "post",
            "terms" => [ { "term_id"=>1, "name"=>"Uncategorized", "slug"=>"uncategorized", "taxonomy"=>"category" } ],
            "to_ping" => ""
          }

          expect(response.content).to eq(expected)
        end
      end

      context "with invalid params", vcr: { cassette_name: "content_integrator/wordpress/publisher/invalid_params" } do
        let(:params) { {} }

        it "raises ValidationError exception" do
          credential = ContentIntegrator::Credential.new({
            url: "http://produtoteste.rockcontent.com",
            token: "d266c97b552de1dc502415f3d7d70ac3",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::ValidationError)
        end
      end

      context "with invalid token", vcr: { cassette_name: "content_integrator/wordpress/publisher/invalid_token" } do
        let(:params) {
          {
            status: "draft",
            title: "My awesome post",
            article: "My awesome article"
          }
        }

        it "raises InvalidCredentialsError" do
          credential = ContentIntegrator::Credential.new({
            url: "http://produtoteste.rockcontent.com",
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid url" do
        let(:params) {
          {
            status: "draft",
            title: "My awesome post",
            article: "My awesome article"
          }
        }

        it "raises InvalidCredentialsError exception" do
          credential = ContentIntegrator::Credential.new({
            url: "111-.wrong-address.com",
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          })
          expect {
            ContentIntegrator::Provider::Wordpress::Publisher.new(credential, params)
          }.to raise_error(ContentIntegrator::InvalidCredentialsError)
        end
      end

      context "with invalid response", vcr: { cassette_name: "content_integrator/wordpress/publisher/invalid_response" } do
        let(:params) {
          {
            status: "draft",
            title: "My awesome post",
            article: "My awesome article"
          }
        }

        it "raises InvalidResponseError exception" do
          credential = ContentIntegrator::Credential.new({
            url: "http://www.rockcontent.com",
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Publisher.new(credential, params)

          expect {
            publisher.call
          }.to raise_error(ContentIntegrator::InvalidResponseError)
        end
      end

    end
  end
end
