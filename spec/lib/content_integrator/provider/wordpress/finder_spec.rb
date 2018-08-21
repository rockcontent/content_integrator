require "spec_helper"
require 'support/vcr'
require "content_integrator"

describe ContentIntegrator::Provider::Wordpress::Finder do
  describe "#call" do
    context "with valid credentials" do

      context "with valid params", vcr: { cassette_name: "content_integrator/wordpress/post_finder/success" } do
        it "has content" do
          credential  = ContentIntegrator::Credential.new({
            url: "http://produtoteste.rockcontent.com",
            token: "d266c97b552de1dc502415f3d7d70ac3",
          })
          endpoint    = ContentIntegrator::Provider::Wordpress::ENDPOINTS[:post]
          resource_id = "69"
          finder      = ContentIntegrator::Provider::Wordpress::Finder.new(credential, endpoint, resource_id)

          response = finder.call

          expected = {
            "post_date" => "2017-08-02 17:39:17",
            "post_date_gmt" => "2017-08-02 17:39:17",
            "post_content" => "My awesome article",
            "post_title" => "My awesome post",
            "post_excerpt" => "",
            "post_status" => "publish",
            "comment_status" => "open",
            "ping_status" => "open",
            "post_password" => "",
            "post_name" => "my-awesome-post",
            "to_ping" => "",
            "pinged" => "",
            "post_modified" => "2017-08-02 17:39:17",
            "post_modified_gmt" => "2017-08-02 17:39:17",
            "post_content_filtered" => "",
            "post_parent" => 0,
            "menu_order" => 0,
            "post_type" => "post",
            "post_mime_type" => "",
            "comment_count" => "0",
            "filter" => "raw",
            "post_id" => 69,
            "guid" => "http://produtoteste.rockcontent.com/?p=69",
            "link" => "http://produtoteste.rockcontent.com/2017/08/02/my-awesome-post/",
            "author" => "1",
            "featured_image" => false,
            "terms" => [ { "term_id"=>1, "name"=>"Uncategorized", "slug"=>"uncategorized", "taxonomy"=>"category" } ]
          }

          expect(response.content).to eq(expected)
        end
      end

      context "with post not found", vcr: { cassette_name: "content_integrator/wordpress/post_finder/post_not_found" } do
        it "raises unknown error" do
          credential  = ContentIntegrator::Credential.new({
            url: "http://localhost/wordpress-4.5.3/",
            token: "e7c2dcf906fcd9f567c03f0920ddc82a",
          })
          endpoint    = ContentIntegrator::Provider::Wordpress::ENDPOINTS[:post]
          resource_id = "999999999999"
          finder      = ContentIntegrator::Provider::Wordpress::Finder.new(credential, endpoint, resource_id)

          expect{
            finder.call
          }.to raise_error(ContentIntegrator::UnknownError)
        end

        it "has error details" do
          credential  = ContentIntegrator::Credential.new({
            url: "http://localhost/wordpress-4.5.3/",
            token: "e7c2dcf906fcd9f567c03f0920ddc82a",
          })
          endpoint    = ContentIntegrator::Provider::Wordpress::ENDPOINTS[:post]
          resource_id = "999999999999"
          finder      = ContentIntegrator::Provider::Wordpress::Finder.new(credential, endpoint, resource_id)

          expected    = [ "Post not found" ]

          expect{
            finder.call
          }.to raise_error(ContentIntegrator::UnknownError) { |error|
            expect(error.details).to eq(expected)
          }
        end
      end

    end
  end
end
