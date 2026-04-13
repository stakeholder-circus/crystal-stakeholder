require "spec"
require "../src/crystal_stakeholder/runtime"

describe Stakeholder::App do
  it "lists the full family registry with renderer metadata" do
    result = Stakeholder::App.run(["--list-values", "--output-format", "json"])
    result.exit_code.should eq(0)

    payload = JSON.parse(result.stdout)
    payload["count"].as_i.should eq(15)

    families = payload["families"].as_a
    names = families.map { |node| node["family"].as_s }
    names.should contain("code_analyzer")
    names.should contain("supply_chain_security")
    names.should contain("overlay_quantum")

    code_analyzer = families.find { |node| node["family"].as_s == "code_analyzer" }
    code_analyzer.not_nil!["rendererKey"].as_s.should eq("crystal.classic.code-analyzer")
    code_analyzer.not_nil!["renderer"].as_s.should eq("crystal.classic.code-analyzer")
    code_analyzer.not_nil!["phase"].as_s.should eq("classic-six")
    code_analyzer.not_nil!["sourceTrace"]["rustPath"].as_s.should contain("code_analyzer.rs")
  end

  it "renders every dedicated family as deterministic JSON" do
    Stakeholder::DEDICATED_FAMILIES.each do |family|
      result = Stakeholder::App.run(["--focus-family", family.name, "--output-format", "json", "--seed", "spec-seed"])
      result.exit_code.should eq(0)

      payload = JSON.parse(result.stdout)
      payload["family"].as_s.should eq(family.name)
      payload["rendererKey"].as_s.should eq(family.renderer_key)
      payload["renderer"].as_s.should eq(family.renderer_key)
      payload["parityClass"].as_s.should eq(family.parity_class)
      payload["events"].as_a.size.should eq(3)
      payload["events"][0]["context"]["trace"]["javaPath"].as_s.should contain("java-stakeholder")
    end
  end

  it "keeps same-seed output stable" do
    left = Stakeholder::App.run(["--focus-family", "platform_engineering", "--output-format", "json", "--seed", "stable-seed"])
    right = Stakeholder::App.run(["--focus-family", "platform_engineering", "--output-format", "json", "--seed", "stable-seed"])

    left.exit_code.should eq(0)
    right.exit_code.should eq(0)
    left.stdout.should eq(right.stdout)
  end

  it "fails fast for experimental provider mode" do
    result = Stakeholder::App.run(["--focus-family", "code_analyzer", "--experimental-provider", "openai"])
    result.exit_code.should eq(2)
    result.stderr.should contain("experimental-provider is not implemented yet in crystal-stakeholder: openai")
  end
end
