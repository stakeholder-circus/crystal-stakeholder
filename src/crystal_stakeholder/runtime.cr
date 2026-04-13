require "json"

module Stakeholder
  record FamilySpec,
    name : String,
    renderer_key : String,
    parity_class : String,
    phase : String,
    summary : String,
    rust_path : String,
    java_path : String,
    contract_path : String

  enum OutputFormat
    Text
    Json
  end

  struct AppResult
    getter exit_code : Int32
    getter stdout : String
    getter stderr : String

    def initialize(@exit_code : Int32, @stdout : String = "", @stderr : String = "")
    end
  end

  DEDICATED_FAMILIES = [
    FamilySpec.new("code_analyzer", "crystal.classic.code-analyzer", "dedicated-classic-six", "classic-six", "Inspect source layout, flag deterministic hotspots, and surface review-ready notes.", "rust-stakeholder/src/generators/code_analyzer.rs:1", "java-stakeholder/src/main/java/com/stakeholder/activities/Activities.java:14", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("data_processing", "crystal.classic.data-processing", "dedicated-classic-six", "classic-six", "Shape fixture data into stable batches and deterministic summary checkpoints.", "rust-stakeholder/src/generators/data_processing.rs:1", "java-stakeholder/src/main/java/com/stakeholder/Main.java:15", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("jargon", "crystal.classic.jargon", "dedicated-classic-six", "classic-six", "Translate specialist wording into shared operational vocabulary without losing intent.", "rust-stakeholder/src/generators/jargon.rs:1", "java-stakeholder/src/main/java/com/stakeholder/config/ConfigTypes.java:6", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("metrics", "crystal.classic.metrics", "dedicated-classic-six", "classic-six", "Render stable KPI checkpoints with deterministic sequence ordering.", "rust-stakeholder/src/generators/metrics.rs:1", "java-stakeholder/src/main/java/com/stakeholder/config/SessionConfig.java:6", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("network_activity", "crystal.classic.network-activity", "dedicated-classic-six", "classic-six", "Summarize edge and service traffic into reproducible transport notes.", "rust-stakeholder/src/generators/network_activity.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("system_monitoring", "crystal.classic.system-monitoring", "dedicated-classic-six", "classic-six", "Report deterministic runtime health and fail-fast telemetry checkpoints.", "rust-stakeholder/src/generators/system_monitoring.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalStore.java:1", "stakeholder-core/docs/generator-source-map.md"),
    FamilySpec.new("agent_workflows", "crystal.modern.agent-workflows", "dedicated-modern-core", "modern-core", "Coordinate repeatable agent handoffs with explicit review and escalation markers.", "rust-stakeholder/src/generators/agent_workflows.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalModels.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("platform_engineering", "crystal.modern.platform-engineering", "dedicated-modern-core", "modern-core", "Describe platform rollout slices, controls, and deterministic release boundaries.", "rust-stakeholder/src/generators/platform_engineering.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalDefaults.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("observability_ai_runtime", "crystal.modern.observability-ai-runtime", "dedicated-modern-core", "modern-core", "Capture runtime inference signals and observability checkpoints with stable provenance.", "rust-stakeholder/src/generators/observability_ai_runtime.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRequest.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("delivery_preview_ops", "crystal.modern.delivery-preview-ops", "dedicated-modern-core", "modern-core", "Stage rollout previews, operator approvals, and go or no-go notes in deterministic order.", "rust-stakeholder/src/generators/delivery_preview_ops.rs:1", "java-stakeholder/src/test/java/com/stakeholder/experimental/ExperimentalRuntimeTest.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("supply_chain_security", "crystal.modern.supply-chain-security", "dedicated-modern-core", "modern-core", "Track artifact integrity, dependency posture, and attestation checkpoints explicitly.", "rust-stakeholder/src/generators/supply_chain_security.rs:1", "java-stakeholder/src/test/java/com/stakeholder/experimental/ExperimentalLiveIntegrationTest.java:1", "stakeholder-core/docs/generator-families.md"),
  ] of FamilySpec

  GROUPED_FALLBACK_FAMILIES = [
    FamilySpec.new("ai_governance", "crystal.grouped.ai-governance", "grouped-fallback", "post-modern-core", "Grouped fallback until dedicated AI governance depth is promoted.", "rust-stakeholder/src/generators/evaluation_and_guardrails.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("security_blockchain", "crystal.grouped.security-blockchain", "grouped-fallback", "post-modern-core", "Grouped fallback until dedicated security and blockchain depth is promoted.", "rust-stakeholder/src/generators/blockchain_protocol_ops.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("health_protocol", "crystal.grouped.health-protocol", "grouped-fallback", "post-modern-core", "Grouped fallback until dedicated healthcare protocol depth is promoted.", "rust-stakeholder/src/generators/hl7v2_feed_ops.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1", "stakeholder-core/docs/generator-families.md"),
    FamilySpec.new("overlay_quantum", "crystal.grouped.overlay-quantum", "grouped-fallback", "post-modern-core", "Grouped fallback until dedicated overlay and quantum-adjacent depth is promoted.", "rust-stakeholder/src/generators/proof_and_sequencer_ops.rs:1", "java-stakeholder/src/main/java/com/stakeholder/experimental/ExperimentalRuntime.java:1", "stakeholder-core/docs/generator-families.md"),
  ] of FamilySpec

  class App
    def self.run(args : Array(String)) : AppResult
      list_values = false
      focus_family : String? = nil
      output_format = OutputFormat::Text
      seed = "default-seed"
      experimental_provider : String? = nil

      index = 0
      while index < args.size
        current = args[index]
        case current
        when "--list-values"
          list_values = true
          index += 1
        when "--focus-family"
          return AppResult.new(1, stderr: "missing value for --focus-family") if index + 1 >= args.size
          focus_family = args[index + 1]
          index += 2
        when "--output-format"
          return AppResult.new(1, stderr: "missing value for --output-format") if index + 1 >= args.size
          normalized = args[index + 1].downcase
          output_format = case normalized
                          when "json" then OutputFormat::Json
                          when "text" then OutputFormat::Text
                          else
                            return AppResult.new(1, stderr: "unsupported output format: #{args[index + 1]}")
                          end
          index += 2
        when "--seed"
          return AppResult.new(1, stderr: "missing value for --seed") if index + 1 >= args.size
          seed = args[index + 1]
          index += 2
        when "--experimental-provider"
          return AppResult.new(1, stderr: "missing value for --experimental-provider") if index + 1 >= args.size
          experimental_provider = args[index + 1]
          index += 2
        when "--help", "-h"
          return AppResult.new(0, stdout: usage_text)
        else
          return AppResult.new(1, stderr: "unexpected positional argument: #{current}\n#{usage_text}")
        end
      end

      if provider = experimental_provider
        return AppResult.new(2, stderr: "experimental-provider is not implemented yet in crystal-stakeholder: #{provider}")
      end

      if list_values
        if output_format.json?
          return AppResult.new(0, stdout: list_values_json)
        end
        return AppResult.new(0, stdout: list_values_text)
      end

      unless family_name = focus_family
        return AppResult.new(1, stderr: "missing required option: --focus-family\n#{usage_text}")
      end

      unless spec = find_family(family_name)
        known = all_families.map(&.name).join(", ")
        return AppResult.new(1, stderr: "unknown family: #{family_name}; known families: #{known}")
      end

      if output_format.json?
        AppResult.new(0, stdout: render_family_json(spec, seed))
      else
        AppResult.new(0, stdout: render_family_text(spec, seed))
      end
    end

    def self.all_families : Array(FamilySpec)
      DEDICATED_FAMILIES + GROUPED_FALLBACK_FAMILIES
    end

    def self.usage_text : String
      [
        "crystal-stakeholder",
        "  --list-values",
        "  --focus-family <family>",
        "  --output-format <text|json>",
        "  --seed <value>",
        "  --experimental-provider <name>",
      ].join("\n")
    end

    def self.find_family(name : String) : FamilySpec?
      all_families.find { |spec| spec.name.downcase == name.downcase }
    end

    def self.list_values_text : String
      all_families.map { |spec| "#{spec.name}\t#{spec.renderer_key}\t#{spec.parity_class}\t#{spec.phase}" }.join("\n")
    end

    def self.list_values_json : String
      JSON.build do |json|
        json.object do
          json.field "count", all_families.size
          json.field "families" do
            json.array do
              all_families.each do |spec|
                build_family_summary(json, spec)
              end
            end
          end
        end
      end
    end

    def self.render_family_text(spec : FamilySpec, seed : String) : String
      messages = render_messages(spec, seed)
      [
        "family=#{spec.name}",
        "rendererKey=#{spec.renderer_key}",
        "renderer=#{spec.renderer_key}",
        "phase=#{spec.phase}",
        "parityClass=#{spec.parity_class}",
        "seed=#{seed}",
        "1|session.start|#{messages[0]}",
        "2|session.signal|#{messages[1]}",
        "3|session.summary|#{messages[2]}",
      ].join("\n")
    end

    def self.render_family_json(spec : FamilySpec, seed : String) : String
      messages = render_messages(spec, seed)
      JSON.build do |json|
        json.object do
          json.field "family", spec.name
          json.field "rendererKey", spec.renderer_key
          json.field "renderer", spec.renderer_key
          json.field "phase", spec.phase
          json.field "parityClass", spec.parity_class
          json.field "seed", seed
          json.field "events" do
            json.array do
              build_event(json, spec, seed, 1, "session.start", messages[0])
              build_event(json, spec, seed, 2, "session.signal", messages[1])
              build_event(json, spec, seed, 3, "session.summary", messages[2])
            end
          end
        end
      end
    end

    def self.render_messages(spec : FamilySpec, seed : String) : Array(String)
      [
        "[#{spec.name}] open deterministic lane for seed #{seed}",
        "[#{spec.name}] apply #{spec.renderer_key} with source trace anchored to Rust and Java",
        "[#{spec.name}] emit review-ready summary for #{spec.phase}",
      ]
    end

    def self.build_family_summary(json : JSON::Builder, spec : FamilySpec) : Nil
      json.object do
        json.field "family", spec.name
        json.field "rendererKey", spec.renderer_key
        json.field "renderer", spec.renderer_key
        json.field "phase", spec.phase
        json.field "parityClass", spec.parity_class
        json.field "summary", spec.summary
        json.field "sourceTrace" do
          build_trace(json, spec)
        end
      end
    end

    def self.build_event(json : JSON::Builder, spec : FamilySpec, seed : String, sequence : Int32, event_type : String, message : String) : Nil
      json.object do
        json.field "eventType", event_type
        json.field "sequence", sequence
        json.field "message", message
        json.field "timestamp", deterministic_timestamp(seed, spec.name, sequence)
        json.field "context" do
          json.object do
            json.field "family", spec.name
            json.field "rendererKey", spec.renderer_key
            json.field "renderer", spec.renderer_key
            json.field "phase", spec.phase
            json.field "seed", seed
            json.field "trace" do
              build_trace(json, spec)
            end
          end
        end
      end
    end

    def self.build_trace(json : JSON::Builder, spec : FamilySpec) : Nil
      json.object do
        json.field "rustPath", spec.rust_path
        json.field "javaPath", spec.java_path
        json.field "contractPath", spec.contract_path
        json.field "parityClass", spec.parity_class
      end
    end

    def self.stable_hash(input : String) : Int32
      acc = 2_166_136_261_u32
      input.each_byte do |byte|
        acc = (acc ^ byte.to_u32) &* 16_777_619_u32
      end
      (acc & 0x7fff_ffff_u32).to_i
    end

    def self.deterministic_timestamp(seed : String, family : String, sequence : Int32) : String
      base = stable_hash("#{seed}:#{family}")
      day = (base % 27) + 1
      hour = ((base // 7) + sequence * 3) % 24
      minute = ((base // 13) + sequence * 11) % 60
      "2026-02-%02dT%02d:%02d:00Z" % {day, hour, minute}
    end
  end
end
