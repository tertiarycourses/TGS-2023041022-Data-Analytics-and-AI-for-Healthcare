# Activity 3: Data Readiness and Imputation

**Learning alignment:** LO2 · A3
**Duration:** 45 minutes
**Tools:** base R, stats

## Objective

Assess data readiness, handle missingness, and document project risks.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/patient_monitoring_dirty.csv`
- `data/project_backlog.csv`
- `activity03_data_readiness.R`

## Detailed procedure

1. Read `data/patient_monitoring_dirty.csv` and confirm 80 patient rows and the five required fields before transformation.
2. Open `activity03_data_readiness.R` and identify the missing-value profile, numeric median loop, readiness export, weighted backlog score, and ranking statements.
3. Run `Rscript --vanilla activity03_data_readiness.R` from the Activity folder.
4. Inspect `outputs/readiness_report.csv` and confirm eight heart-rate values and seven SpO2 values were missing before imputation.
5. Classify each missing field as a plausible MCAR, MAR, or MNAR hypothesis and state what operational evidence would distinguish these mechanisms.
6. Inspect the median-imputation loop and explain why it is a transparent teaching baseline but not automatically a production method.
7. Open `outputs/patient_monitoring_clean.csv` and verify no numeric fields remain missing using `colSums(is.na(read.csv('outputs/patient_monitoring_clean.csv')))`.
8. Check cleaned ranges with `summary()` and confirm heart rate and SpO2 remain plausible for this synthetic exercise.
9. Compare at least one field's median before and after cleaning and describe the variance-distortion risk of single-value imputation.
10. Read `data/project_backlog.csv` and confirm all four criteria use the same 1-to-10 direction, where a higher value is preferred.
11. Recalculate one project score using `0.35*clinical_impact + 0.25*data_readiness + 0.20*feasibility + 0.20*time_to_value`.
12. Open `outputs/prioritised_backlog.csv` and confirm Ward demand ranks first with a score of 8.45.
13. Perform a sensitivity prompt: explain whether a lower data-readiness weight could change the first-ranked project and why weights require stakeholder agreement.
14. Create a risk note naming the data owner, missingness concern, approved handling rule, and escalation trigger.
15. Apply the acceptance checks and submit all three output CSVs, the manual score check, a readiness decision, and its stated limitations.

Run from the Activity folder:

```bash
Rscript --vanilla activity03_data_readiness.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/readiness_report.csv` shows 8 missing heart-rate values and 7 missing SpO2 values before imputation, then zero for numeric fields.
- `outputs/prioritised_backlog.csv` ranks Ward demand above the other supplied projects with the stated weights.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If medians are `NA`, the entire field is missing and must be escalated rather than imputed.
- If the priority order changes, verify weights and ensure every criterion uses the same 1-10 scale.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
