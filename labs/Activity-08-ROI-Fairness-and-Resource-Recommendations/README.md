# Activity 8: ROI Fairness and Resource Recommendations

**Learning alignment:** LO4 · A8
**Duration:** 60 minutes
**Tools:** S4Vectors (optional), stats

## Objective

Evaluate value and subgroup performance, then recommend resource allocation.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/regional_predictions.csv`
- `data/intervention_costs.csv`
- `activity08_recommendations.R`

## Detailed procedure

1. Read `data/regional_predictions.csv`; confirm five regions, two groups per region, and 10 total prediction rows.
2. Read `data/intervention_costs.csv`; confirm three interventions and positive program cost, effectiveness, and value-per-case fields.
3. Open `activity08_recommendations.R` and locate the merge, cases-avoided, benefit, ROI, subgroup calibration, ranking, and output statements.
4. Run `Rscript --vanilla activity08_recommendations.R` from the Activity folder.
5. Confirm the merge preserves 10 rows and every region-group option finds exactly one intervention-cost record.
6. For one option, manually calculate `population * predicted_risk * effectiveness` and compare it with `expected_cases_avoided`.
7. Calculate benefit as cases avoided times value per case and confirm program cost uses the same currency and time horizon.
8. Recalculate ROI for the same option using `(benefit - program_cost) / program_cost`.
9. Open `outputs/recommendation_matrix.csv`; quote the highest-ranked option and its ROI, expected cases avoided, and program cost.
10. Open `outputs/subgroup_check.csv`; confirm 10 region-group rows and inspect `calibration_gap = predicted_risk - observed_rate`.
11. Within each region, compare adult and older calibration gaps and flag the largest absolute gap for review.
12. Apply a capacity constraint of your choice and explain which options would be funded, deferred, or require negotiation.
13. Write a recommendation that separates observation, inference, option, trade-off, chosen action, and monitoring measure.
14. Specify at least three monitoring KPIs and one stop condition covering clinical value, calibration/equity, cost, or operational burden.
15. Apply the acceptance checks and submit both CSVs, two manual calculations, subgroup review, ranked recommendation, assumptions, and stop condition.

Run from the Activity folder:

```bash
Rscript --vanilla activity08_recommendations.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/recommendation_matrix.csv` contains 10 region-group options; South/older Telehealth ranks first with 3,456 expected cases avoided and ROI about 158.51 in the synthetic calculation.
- `outputs/subgroup_check.csv` contains adult and older-group calibration gaps for all five regions; the largest absolute gap is 0.005 in North for both groups.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If ROI is infinite, program cost is zero or missing and must be corrected before ranking.
- If subgroup gaps change sign, confirm predicted and observed rates use the same population and time window.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
