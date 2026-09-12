# Activity 4: Hypothesis-Driven Readmission Model

**Learning alignment:** LO2 · A4
**Duration:** 45 minutes
**Tools:** stats, BiocParallel (optional)

## Objective

Configure and compare models that test an organisational healthcare hypothesis.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/readmission_patients.csv`
- `activity04_readmission_model.R`

## Detailed procedure

1. Read `data/readmission_patients.csv`; confirm 160 rows, a binary `readmitted` outcome, and that every candidate predictor is available before the prediction time.
2. Write the analysis contract before fitting: population, discharge-time prediction point, outcome window assumption, candidate features, threshold, and acceptance criteria.
3. Open `activity04_readmission_model.R` and locate the fixed seed, 75/25 split, baseline model, customised model, threshold, metric function, and output writers.
4. Run `Rscript --vanilla activity04_readmission_model.R` from the Activity folder.
5. Confirm the script uses `set.seed(1022)` and record 120 training rows and 40 test rows after sourcing.
6. Inspect the baseline formula and explain why it contains age, prior admissions, and length of stay.
7. Inspect the customised formula and confirm it adds discharge support and comorbidity count without adding the outcome or a post-outcome proxy.
8. Open `outputs/model_comparison.csv` and quote AIC, accuracy, and sensitivity for both models.
9. Explain why lower AIC supports relative fit while accuracy and sensitivity describe different decision consequences.
10. Verify the classification threshold is 0.40 and describe the likely workload trade-off of lowering or raising it.
11. Open `outputs/model_coefficients.csv`; confirm the intercept plus five predictor terms are present.
12. Identify the two largest absolute non-intercept coefficient estimates and interpret direction cautiously, without converting association into treatment effect.
13. Document checks for temporal leakage, sparse categories, separation, calibration, and subgroup performance.
14. Recommend whether the customised model should advance to validation, be revised, or stop; tie the decision to quoted evidence and a predeclared criterion.
15. Apply the acceptance checks and submit both CSVs, the analysis contract, model comparison, two coefficient interpretations, and control actions.

Run from the Activity folder:

```bash
Rscript --vanilla activity04_readmission_model.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/model_comparison.csv` contains two rows: baseline AIC 97.5610, accuracy 0.90, sensitivity 0.9474; customised AIC 101.1381, accuracy 0.90, sensitivity 0.8947.
- `outputs/model_coefficients.csv` includes the intercept and five customised-model terms; prior_admissions has the largest absolute non-intercept estimate (about 1.7098).

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If sensitivity is `NaN`, the test split contains no positive outcomes; preserve the seed or use stratified splitting.
- If a coefficient is extreme, inspect sparse categories, separation, and leakage before interpretation.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
