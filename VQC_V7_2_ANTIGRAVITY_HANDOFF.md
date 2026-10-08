# VQC v7.2.0 — Antigravity Handoff

Integrate this build into the existing VQC repository; do not greenfield-rebuild the app.

## Hard gates
1. `npm ci`
2. `npm run lint`
3. `npm test`
4. `npm run build`
5. Verify all six external sources appear in the registry and curriculum prompts.
6. Verify raw third-party media is NOT bundled.
7. Verify `3x1 = TRIPS`, `2x2 = DOUBLES / 2x2`, and Bunch/Stack/Condensed remain presentation modifiers rather than geometry replacements.
8. Verify SportR/VideoNet/MUVY/Football Player Tracking/Sports-1M cannot override current-film evidence or write directly to `SnapMaster`.
9. Verify the normalized curriculum schema rejects tactical capability escalation (e.g. Sports-1M→coverage or MUVY→run concept).
10. Run regression film containing 3x1, 2x2, Empty, Bunch, Stack, motion-changing-distribution, occlusion/crop, ambiguous end-zone film, Cover-2/Tampa-2 ambiguity, and run-concept hard negatives.
11. Do not certify if any clear 3x1 snap finishes as Spread/2x2 or if an external label is surfaced as opponent evidence without current-film support.

## External data import policy
VQC does not auto-download restricted/gated media. Locally obtain only datasets you are authorized to use.

Use:
- `npm run curriculum:build -- ...` to inventory local copies and produce provenance summaries.
- `npm run curriculum:normalize -- ...` to normalize authorized Big Data Bowl / VideoNet / SportR metadata into VQC curriculum JSONL.

The external curriculum is an offline training/evaluation/reference layer. It is NOT a replacement for current VQC film evidence.
