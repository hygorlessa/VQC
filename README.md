# VQC v7.1.1 — Virtual Quality Control & Advance Scout

Production-oriented American Football film analysis, Quality Control, Advance Scout and Game Planning platform.

## v7.1 focus: Agent Accuracy

VQC 7.1 rebuilds the film-analysis staff around a shared football curriculum and independent structural verification. The default film pipeline is:

`Media → Film Tagger → Formation Verifier → Tactical Analyst → QC Validator → Evidence-Verified Data`

Key accuracy safeguards include:

- mandatory at-snap formation geometry census before naming a formation;
- deterministic normalization of 3x1/1x3 to **TRIPS** and 2x2 to **DOUBLES / 2x2**;
- an independent Formation Verifier that does not receive the Film Tagger's label;
- a third independent formation recount by QC;
- evidence-frame indices on RawObservations;
- deep-model / temperature-0 defaults for film agents;
- strict current `evidenceVersion + analysisRunId` lineage;
- AI blocked until the snap moment is coach-confirmed by default;
- contradictions fail safe to `UNKNOWN`, `CONTESTED`, `LIMITED`, or `EXCLUDED` rather than a confident invented classification.

See `docs/VQC_V7_1_AGENT_ACCURACY.md` for the architecture and acceptance criteria.

## Local development

Prerequisites: Node.js 22+, npm, ffmpeg/ffprobe, and Google Cloud/Firebase configuration described in `.env.example`.

```bash
npm ci
npm run lint
npm test
npm run build
npm run dev
```

The production backend uses Google Cloud credentials/ADC and Vertex AI; do not store service-account private keys in the source tree.

## v7.1.1 Foundational Football Memory

The agent curriculum includes a compact, paraphrased foundational reference layer derived from *Football For Dummies, 7th Edition* (Howie Long with John Czarnecki, 2023). The PDF itself is not bundled. Visual evidence and VQC's advanced deterministic taxonomy remain authoritative.


## 7.2.1 — evidence-grounded external knowledge (offline-first)

`npm run curriculum:normalize -- --big-data-bowl-plays PATH/plays.csv --videonet-jsonl PATH/vn.jsonl --sportr-jsonl PATH/sr.jsonl --football-tracking-jsonl PATH/player_annotations.jsonl --muvy-jsonl PATH/muvy.jsonl --sports1m-jsonl PATH/labels.jsonl --out /authorized/local/normalized.jsonl` builds **metadata examples only**; see the rejection report next to the output. Data access and license approval remain your responsibility. Dataset-specific schemas/rights must be checked before use. No raw videos are included.

Production inference only: configure `VQC_EXTERNAL_CURRICULUM_AUTHORIZED=true` and `VQC_CURRICULUM_STORE_PATH=/absolute/private/normalized.jsonl` **after licensing review**. The selector admits only `PROMPT_DISTILLATION`-eligible entries in production; research-restricted SportR/VideoNet/MUVY/player-tracking examples stay out. The AI agents always prioritize current clip evidence. This is retrieval, NOT fine-tuning or demonstrated accuracy improvement.

Independent film path: `npm run film:offline -- --video /absolute/film.mp4 --snap-at 3.25,12.2 --out /private/evidence` (requires ffmpeg/ffprobe). Produces 12 phase-indexed JPEG frames per snap and a SHA-256 manifest that can be reviewed without uploading into VQC; no automatic tactical prediction without a connected vision model.

New authenticated read-only endpoints `/api/agents/advance-scout/brief` and `/api/agents/special-teams/brief` aggregate **audited VQC evidence only**. They do not synthesize opponent facts from external examples. Optional rate-limited `POST /api/agents/advance-scout/analyze` and `POST /api/agents/special-teams/analyze` use Vertex AI with evidence ID validation (requires working GCP credentials and a real deploy).

Run `npm run test:offline` for deterministic subset without npm dependencies; `npm test`, `npm run lint` and `npm run build` still require `npm ci`. `npm run package:release` regenerates a manifest; `npm run release:verify` verifies all SHA-256 values and canonical tree hash. See `docs/VQC_V7_2_1_VALIDATION_AND_LIMITS.md`.

Offline evaluation: `npm run benchmark:film -- --gold human-reviewed.jsonl --baseline old.jsonl --candidate new.jsonl --out scores.json` compares formation, coverage, run and play labels on identical VQC snap IDs. Synthetic fixtures validate mechanics but cannot establish model accuracy.
