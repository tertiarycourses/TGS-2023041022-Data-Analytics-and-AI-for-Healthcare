# Activity 2: Oncology Cohort Insights

**Learning alignment:** LO1 · A2
**Duration:** 45 minutes
**Tools:** SummarizedExperiment, S4Vectors

## Objective

Analyse de-identified cohort and biomarker data to extract cautious, decision-relevant insights.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/expression_matrix.csv`
- `data/sample_metadata.csv`
- `activity02_cohort_insights.R`

## Detailed procedure

1. Read `data/sample_metadata.csv`; confirm 12 unique sample identifiers, six controls, six cases, and no duplicated `sample_id` values.
2. Read the header of `data/expression_matrix.csv`; confirm its 12 assay columns are in exactly the same order as `sample_metadata$sample_id`.
3. Open `activity02_cohort_insights.R` and identify the assay import, optional `SummarizedExperiment` branch, group means, ranking, and heatmap sections.
4. Run `Rscript --vanilla activity02_cohort_insights.R` from the Activity folder and confirm that `outputs/` is created automatically.
5. If `SummarizedExperiment` and `S4Vectors` are installed, verify the script builds an aligned container; otherwise record that only the base-R fallback was exercised.
6. Run `dim(expr)` after sourcing the script; the observable dimensions must be 30 genes by 12 samples.
7. Confirm `identical(colnames(expr), meta$sample_id)` returns `TRUE`; stop and repair metadata order if it does not.
8. Inspect the calculations for `case_mean`, `control_mean`, and `delta`; manually check the delta for the first ranked gene.
9. Open `outputs/cohort_insights.csv` and confirm it contains 30 rows sorted by decreasing absolute delta.
10. Quote the top-ranked gene, its case mean, control mean, and signed delta as an observation rather than a diagnostic claim.
11. Open `outputs/cohort_heatmap.png`; identify whether samples with the same supplied group label show broadly similar colour patterns.
12. Check for a sample whose visual pattern differs from peers and propose a QC investigation without deleting it automatically.
13. Write two evidence statements: one about magnitude/direction and one about cohort pattern; attach an exact output value to each.
14. State limitations covering synthetic data, small cohort size, absence of covariate adjustment, and lack of external validation.
15. Apply the acceptance checks and submit the ranked CSV, heatmap, two evidence statements, one QC action, and the limitations.

Run from the Activity folder:

```bash
Rscript --vanilla activity02_cohort_insights.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/cohort_insights.csv` has 30 gene rows sorted by absolute case-control difference; GENE003 is first with case mean 8.2667, control mean 7.0417, and delta 1.225.
- `outputs/cohort_heatmap.png` shows 12 samples with six controls and six cases.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If SummarizedExperiment is unavailable, the base-R calculation still runs; record that the Bioconductor container path was not executed.
- If dimensions fail, compare `colnames(expression_matrix)` with `sample_metadata$sample_id` before analysis.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
