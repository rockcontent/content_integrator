require "spec_helper"
require "content_integrator"
require "support/vcr"

describe ContentIntegrator::Utils do
  describe ".symbolize_keys" do
    context "with hash not symbolized" do
      it "returns a hash with symbolized keys" do
        hash = { "a" => 1, "b" => 2 }

        response = ContentIntegrator::Utils.symbolize_keys(hash)
        expected = { a: 1, b: 2 }

        expect(response).to eq(expected)
      end
    end

    context "with hash symbolized" do
      it "returns the same hash" do
        hash = { a: 1, b: 2 }

        response = ContentIntegrator::Utils.symbolize_keys(hash)
        expected = { a: 1, b: 2 }

        expect(response).to eq(expected)
      end
    end

    context "with empty hash" do
      it "returns an empty hash" do
        hash = {}

        response = ContentIntegrator::Utils.symbolize_keys(hash)
        expected = {}

        expect(response).to eq(expected)
      end
    end

    context "with a nil param" do
      it "raise a NoMethodError exception" do
        hash = nil

        expect {
          ContentIntegrator::Utils.symbolize_keys(hash)
        }.to raise_error(NoMethodError)
      end
    end
  end

  describe ".open_image_from_url" do
    context "when the image is bigger than 10KB", vcr: { cassette_name: "content_integrator/utils/big_image" } do
      it "returns the image as Tempfile" do
        image_url = "https://www.w3schools.com/css/paris.jpg"

        expect(ContentIntegrator::Utils.open_image_from_url(image_url)).to be_a(Tempfile)
      end
    end

    context "when the image is less than 10KB", vcr: { cassette_name: "content_integrator/utils/smal_image" } do
      it "returns the image as File" do
        image_url = "https://s3-us-west-2.amazonaws.com/rc2-development/img/branco.jpg"

        expect(ContentIntegrator::Utils.open_image_from_url(image_url)).to be_a(File)
      end
    end
  end

  describe ".parse_expiration_date" do
    context "with expires_at" do
      it "returns time object" do
        time = Time.new(2017)
        allow(Time).to receive(:now).and_return(time)

        expires_at = 60
        expected   = time + expires_at

        expect(ContentIntegrator::Utils.parse_expiration_date(expires_at)).to eq(expected)
      end
    end

    context "with empty expires_at" do
      it "returns nil" do
        expires_at = ""
        expect(ContentIntegrator::Utils.parse_expiration_date(expires_at)).to be_nil
      end
    end

    context "with nil expires_at" do
      it "returns nil" do
        expires_at = nil
        expect(ContentIntegrator::Utils.parse_expiration_date(expires_at)).to be_nil
      end
    end
  end
end
