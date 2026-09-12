# Activity 7: Pathway Results Communication

**Learning alignment:** LO4 · A7
**Duration:** 60 minutes
**Tools:** clusterProfiler, enrichplot

## Objective

Communicate functional-analysis results with uncertainty and audience-specific evidence.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/differential_genes.csv`
- `data/mock_gene_sets.csv`
- `activity07_pathway_story.R`

## Detailed procedure

1. Read `data/differential_genes.csv` and confirm 60 genes with signed effects and adjusted p-values.
2. Read `data/mock_gene_sets.csv` and confirm four named pathways with 18 listed genes each before deduplication.
3. Open `activity07_pathway_story.R` and locate the significance filter, universe, pathway split, overlap count, hypergeometric test, BH adjustment, and evidence chart.
4. Run `Rscript --vanilla activity07_pathway_story.R` from the Activity folder.
5. Confirm the script defines significant genes using adjusted p-value below 0.05 and record the resulting count.
6. Inspect `universe <- unique(sets$gene)` and explain why the reference universe must represent genes that could have been detected.
7. For one pathway, manually count overlap between its genes and the significant-gene list.
8. Trace the `phyper(overlap-1, set_size, universe-set_size, significant_count, lower.tail=FALSE)` call and explain the chance-overlap question.
9. Open `outputs/pathway_enrichment.csv`; confirm four pathway rows and the overlap, set size, raw p-value, and adjusted p-value fields.
10. Quote the top-ranked pathway, overlap, and adjusted p-value as a statistical observation.
11. Open `outputs/pathway_evidence.png`; confirm all four pathway labels and explain the `-log10(adjusted p)` evidence scale.
12. Write a clinician-facing message focused on biological plausibility and validation, using no more than three sentences.
13. Write an executive-facing message focused on the decision, uncertainty, resource implication, and next validation gate.
14. State limitations involving the mock gene sets, overlapping genes, database version, universe choice, and absence of causal proof.
15. Apply the acceptance checks and submit the CSV, chart, manual overlap check, both audience messages, and limitations.

Run from the Activity folder:

```bash
Rscript --vanilla activity07_pathway_story.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/pathway_enrichment.csv` contains four pathways; Inflammation ranks first with overlap 18/18 and BH-adjusted p-value about 1.66e-10.
- `outputs/pathway_evidence.png` plots the adjusted evidence scale and labels Inflammation, Cell cycle, DNA repair, and Metabolism.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If all adjusted p-values are one, inspect the significant-gene threshold and reference universe rather than loosening the threshold.
- If pathway names disappear, verify `mock_gene_sets.csv` has `pathway` and `gene` columns.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
