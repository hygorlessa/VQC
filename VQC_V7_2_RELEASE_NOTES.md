# VQC v7.2.0 — External Football Curriculum & Multisource Benchmark Memory

## Purpose
Improve agent accuracy using all external sources previously selected, excluding the user's already-analyzed VQC film.

## Sources integrated
- NFL Big Data Bowl 2025
- Football Player Tracking Dataset
- MUVY
- VideoNet
- SportR
- Sports-1M (broad-domain prior only)

## Major changes
- source-aware curriculum memory injected into Film Tagger, Formation Verifier, Tactical Analyst, QC, Advance Scout and Special Teams;
- external-source registry with reliability, access terms, legal-use boundaries and allowed capabilities;
- Big Data Bowl field-to-VQC mapping for formation geometry, run/coverage, pressure, situation and tracking;
- normalized external curriculum schema that stays separate from opponent `SnapMaster` evidence;
- local normalization adapters for authorized Big Data Bowl, VideoNet and SportR metadata;
- player-detection/counting/tracking curriculum from Football Player Tracking;
- MUVY camera/viewpoint/blur/occlusion/multi-view robustness curriculum;
- VideoNet hard-negative and few-shot action-discrimination methodology;
- SportR locate→describe→ground→classify→challenge methodology;
- Sports-1M explicitly restricted to broad sports-domain recognition;
- local inventory/manifest builder and normalized JSONL builder; neither downloads nor redistributes raw third-party media;
- acquisition/rights guide and normalized-schema documentation;
- regression tests enforcing source capability boundaries and 3x1 geometry discipline.

## Critical integrity rule
External source labels are curriculum priors only. They NEVER become opponent-specific facts, tendencies, vulnerabilities, or game-plan claims without current-snap VQC evidence.


## Addendum — VQC 7.2.1 hardening
- Validators and identifiers for all six metadata sources, with rejection/dedup reports and rights gates.
- Bounded read-only example retrieval into four core model stages; opt-in and permitted-use gated.
- Advance Scout / Special Teams endpoints (audited deterministic summaries and optional Vertex inference with evidence claim binding).
- Offline video frame bundles with ffmpeg and SHA-256 provenance (no platform upload needed).
- Independent release manifest recomputation and offline deterministic test runner.
- No full source datasets, real-game benchmark, fine-tuning, or Cloud Run deployment are claimed.
