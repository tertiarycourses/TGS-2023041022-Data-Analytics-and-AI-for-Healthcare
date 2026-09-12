# Activity 5: Genomic Data Mining with limma

**Learning alignment:** LO3 · A6
**Duration:** 60 minutes
**Tools:** limma, Biobase

## Objective

Run a reproducible differential-expression pipeline and interpret model evidence.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/gene_expression.csv`
- `data/sample_metadata.csv`
- `activity05_limma.R`

## Detailed procedure

1. Read `data/sample_metadata.csv`; confirm 16 unique samples split into eight controls and eight cases.
2. Read `data/gene_expression.csv`; confirm 80 gene rows and that its 16 assay-column names exactly match metadata order.
3. Open `activity05_limma.R` and locate the design matrix, contrast, `limma` branch, base-R fallback, multiple-testing adjustment, PCA, and exports.
4. Run `Rscript --vanilla activity05_limma.R` from the Activity folder.
5. Record whether `requireNamespace('limma', quietly=TRUE)` is `TRUE`; do not claim empirical-Bayes moderation if the fallback branch ran.
6. Inspect `design <- model.matrix(~0 + factor(meta$group))` and confirm the two columns are renamed `control` and `case`.
7. Explain the `case-control` contrast as a signed case-minus-control effect, so a positive log fold change indicates higher case expression.
8. If limma is installed, trace `lmFit`, `contrasts.fit`, `eBayes`, and `topTable`; otherwise trace the per-gene t-test and BH adjustment.
9. Open `outputs/differential_expression.csv`; confirm 80 rows and the presence of effect, raw p-value, adjusted p-value, and gene identifier fields.
10. Quote the top-ranked gene's signed effect and adjusted p-value and state which analysis branch generated it.
11. Count genes below adjusted p-value 0.05 and report the count as screening evidence, not as validated biomarkers.
12. Open `outputs/pca.png`; verify 16 plotted sample scores and colours corresponding to eight controls and eight cases.
13. Describe whether PC1/PC2 show separation, overlap, or a possible outlier, and name a batch-effect or metadata check that should follow.
14. State limitations covering sample size, synthetic signal, multiplicity, unmodelled covariates, and need for independent biological validation.
15. Apply the acceptance checks and submit the ranked CSV, PCA, branch declaration, one quantitative finding, and the validation limitations.

Run from the Activity folder:

```bash
Rscript --vanilla activity05_limma.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/differential_expression.csv` contains 80 genes with effect, p-value, and adjusted p-value evidence; on the base-R fallback G002 is first with logFC 1.4625 and adjusted p-value about 1.22e-14. The limma branch may rank ties differently.
- `outputs/pca.png` contains 16 sample scores coloured as eight controls and eight cases.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If limma is unavailable, the script uses a base-R t-test fallback; do not claim empirical-Bayes moderation was executed.
- If PCA fails, check for constant genes or non-numeric assay cells and remove them with a documented rule.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
