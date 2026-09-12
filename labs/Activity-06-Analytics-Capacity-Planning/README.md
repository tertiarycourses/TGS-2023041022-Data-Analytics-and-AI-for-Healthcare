# Activity 6: Analytics Capacity Planning

**Learning alignment:** LO3 · A5
**Duration:** 60 minutes
**Tools:** base R

## Objective

Allocate team and compute capacity to prioritised healthcare analytics work.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## Files

- `data/team_capacity.csv`
- `data/pipeline_jobs.csv`
- `activity06_capacity_plan.R`

## Detailed procedure

1. Read `data/team_capacity.csv` and confirm four roles with 108 total available hours.
2. Read `data/pipeline_jobs.csv` and confirm five jobs with 130 total demand hours.
3. Open `activity06_capacity_plan.R` and locate the weighted-demand calculation, totals, utilisation, priority ordering, cumulative allocation, and exports.
4. Run `Rscript --vanilla activity06_capacity_plan.R` from the Activity folder.
5. Open `outputs/capacity_summary.csv` and verify 108 available hours, 130 demand hours, and utilisation of approximately 1.204.
6. Explain why demand above capacity creates a queue and why sustained utilisation close to 100% leaves no buffer for incidents or rework.
7. Inspect `weighted_demand <- hours * (1 + priority/10)` and explain what this teaching indicator adds beyond raw hours.
8. Confirm allocation order is descending priority and then descending clinical impact.
9. Open `outputs/capacity_allocation.csv` and list which work is scheduled and which work is deferred by the cumulative-hour rule.
10. Recalculate the cumulative hours at the boundary where the first defer decision occurs.
11. Compare required work with the supplied skill labels and identify one plausible skill bottleneck that aggregate hours conceal.
12. Propose one short-term action (defer or re-sequence), one capability action (cross-train), and one platform action (scale compute or automate).
13. Assign an owner, due date, and review metric to each proposed action.
14. State limitations of the greedy allocation: jobs are treated as indivisible, dependencies are omitted, and role-specific capacity is simplified.
15. Apply the acceptance checks and submit both CSVs, boundary calculation, bottleneck interpretation, and governed capacity actions.

Run from the Activity folder:

```bash
Rscript --vanilla activity06_capacity_plan.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/capacity_summary.csv` reports 108 available hours, 130 demand hours, and utilisation 1.2037.
- `outputs/capacity_allocation.csv` schedules Readmission model, Cohort QC, DE analysis, and Dashboard (106 cumulative hours), then defers Archive study.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If utilisation is below one unexpectedly, confirm job hours were not parsed as text.
- If every job is scheduled despite excess demand, inspect the cumulative-hours condition and capacity units.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
