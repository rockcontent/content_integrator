require "spec_helper"
require "content_integrator"

describe ContentIntegrator::Response do
  describe "#new" do
    context "with content" do
      it "returns content" do
        response = ContentIntegrator::Response.new(content: { ok: "ok" })

        expect(response.content).to eq({ ok: "ok" })
      end
    end

    context "with content and credentials" do
      it "returns content" do
        response = ContentIntegrator::Response.new(content: { ok: "ok" }, credentials: { token: "123" })

        expect(response.content).to eq({ ok: "ok" })
      end

      it "returns credentials" do
        response = ContentIntegrator::Response.new(content: { ok: "ok" }, credentials: { token: "123" })

        expect(response.credentials).to eq({ token: "123" })
      end
    end

    context "without content" do
      it "raises ArgumentError" do
        expect {
          ContentIntegrator::Response.new
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#to_json" do
    it "returns a hash" do
      response = ContentIntegrator::Response.new(content: { ok: "ok" }, credentials: { token: "123" })

      expected = {
        content: { ok: "ok" },
        credentials: { token: "123" }
      }

      expect(response.to_json).to eq(expected)
    end
  end
end
