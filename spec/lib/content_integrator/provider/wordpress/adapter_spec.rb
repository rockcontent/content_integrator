require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Adapter do
  describe "#connect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/connector/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        connector = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

        response = connector.connect

        expected = {
          "activated_at" => "2017-08-02 17:05:59",
          "php_version" => "5.6.31",
          "rcp_version" => "2.0.0",
          "redirect_path" => "http://produtoteste.rockcontent.com/wp-admin/admin.php?page=rcp_plugin_options&integrated=success",
          "wordpress_version" => "4.8",
        }

        expect(response.content).to eq(expected)
      end

      it "has credentials" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        connector = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

        response = connector.connect

        expected = {
          "url" => "http://produtoteste.rockcontent.com",
          "token" => "d266c97b552de1dc502415f3d7d70ac3",
        }

        expect(response.credentials).to eq(expected)
      end
    end
  end

  describe "#disconnect" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/disconnector/success" } do
      it "has content with disconnect date" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        disconnector = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

        response = disconnector.disconnect

        expected = {
          "disconnected_at" => "2017-08-02 16:19:43",
        }

        expect(response.content).to eq(expected)
      end
    end
  end

  describe "#publish" do
    context "with valid credentials" do
      context "with valid params", vcr: { cassette_name: "content_integrator/wordpress/publisher/success" } do
        let(:params) {
          {
            status: "draft",
            title: "My awesome post",
            article: "My awesome article"
          }
        }

        it "has content" do
          credential = ContentIntegrator::Credential.new({
            url: "http://produtoteste.rockcontent.com",
            token: "d266c97b552de1dc502415f3d7d70ac3",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

          response = publisher.publish(params)

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
          publisher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

          expect {
            publisher.publish(params)
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
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            url: "http://produtoteste.rockcontent.com",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

          expect {
            publisher.publish(params)
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
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            url: "111-.wrong-address.com",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

          expect {
            publisher.publish(params)
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
            token: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
            url: "http://www.rockcontent.com",
          })
          publisher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

          expect {
            publisher.publish(params)
          }.to raise_error(ContentIntegrator::InvalidResponseError)
        end
      end
    end
  end

  describe "#categories" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/categories/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        fetcher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

        response = fetcher.categories

        expected = [ { :id=>"1", :name=>"Uncategorized" } ]

        expect(response.content).to eq(expected)
      end
    end
  end

  describe "#users" do
    context "with valid credentials", vcr: { cassette_name: "content_integrator/wordpress/users/success" } do
      it "has content" do
        credential = ContentIntegrator::Credential.new({
          url: "http://produtoteste.rockcontent.com",
          token: "d266c97b552de1dc502415f3d7d70ac3",
        })
        fetcher = ContentIntegrator::Provider::Wordpress::Adapter.new(credential)

        response = fetcher.users

        expected = [ { :id=>"1", :name=>"produto" }, { :id=>"4", :name=>"raff" } ]

        expect(response.content).to eq(expected)
      end
    end
  end
end
