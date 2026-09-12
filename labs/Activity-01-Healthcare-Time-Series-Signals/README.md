# Activity 1: Healthcare Time-Series Signals

**Learning alignment:** LO1 · A1
**Duration:** 45 minutes
**Tools:** base R, stats, graphics

## Objective

Interpret temporal patterns and translate them into operational implications.

## Scenario and deliverable

Use the supplied synthetic, de-identified mock data to produce the evidence files in `outputs/`. Submit the output tables/visuals plus a short interpretation that separates observation, inference, recommendation, and limitation. These datasets are for learning and must not be used for clinical care.

## R 4.6 RStudio and Bioconductor 3.23 setup

1. Download and install R 4.6.x from CRAN for your operating system. Restart the computer if the installer updates system libraries.
2. Download and install RStudio Desktop from Posit. RStudio is the interface; R is the execution engine and must be installed first.
3. In the RStudio Console, verify `R.version.string`. The course target is R 4.6.x.
4. Install the Bioconductor manager with `install.packages("BiocManager")`.
5. Install the course Bioconductor release with `BiocManager::install(version = "3.23")`.
6. Install packages with `BiocManager::install(c("SummarizedExperiment","S4Vectors","Biobase","limma","ComplexHeatmap","clusterProfiler","enrichplot"))`.
7. Verify with `BiocManager::valid()` and `sessionInfo()`. Save the output when requesting support.

### Troubleshooting

- `R version is too old`: install R 4.6.x, restart RStudio, and check Tools > Global Options > General points to the new R installation.
- `Bioconductor version cannot be installed`: confirm the R/Bioconductor release pair; Bioconductor 3.23 requires the corresponding R 4.6 release.
- Package compilation fails on macOS: install current Xcode Command Line Tools; on Windows install the matching Rtools release.
- A package is unavailable: run `BiocManager::valid()`, update outdated packages, and retry one package at a time.
- Script cannot find a CSV: keep the supplied `data/` folder beside the script and run the script without changing the working directory.
- Corporate proxy blocks downloads: ask IT to allow CRAN and Bioconductor repositories or use an approved internal mirror.

## Files

- `data/dengue_hospital_demand.csv`
- `activity01_time_series.R`

## Detailed procedure

1. Read `data/dengue_hospital_demand.csv` and confirm it contains 36 rows, 12 monthly dates, and the three regions East, North, and West.
2. Open `activity01_time_series.R` and locate the path resolver, version diagnostic, occupancy calculation, daily aggregation, and PNG device sections before running anything.
3. From this Activity folder run `Rscript --vanilla activity01_time_series.R`; in RStudio use Source with Echo so the same statements appear in the Console.
4. Confirm the Console prints the resolved Activity directory and finishes without an unhandled error.
5. Open `outputs/setup_diagnostic.csv` and compare the observed R version with `>= 4.6.0` and the observed Bioconductor release with `3.23`.
6. If the target environment is installed, run `Rscript --vanilla -e "cat(R.version.string); library(BiocManager); print(BiocManager::version()); BiocManager::valid()"` and retain the verification output.
7. Inspect the script statement `d$date <- as.Date(d$date)` and verify every parsed date is non-missing with `stopifnot(!anyNA(d$date))` in the Console.
8. Recalculate `occupancy_pct <- 100 * occupied_beds / staffed_beds` for one selected row and compare it with the script result.
9. Confirm the aggregation produces 12 monthly records by running `nrow(agg)` after sourcing the script; the observable value must be 12.
10. Open `outputs/dengue_trend.png` and identify the blue dengue-case series, red mean-occupancy series, labelled axes, and 12 monthly positions.
11. Record the first and last mean case counts and state the direction of change without claiming causality.
12. Identify the month with the highest mean occupancy using `agg[which.max(agg$occupancy_pct), ]` and quote the month and percentage.
13. Write one operational implication, such as reviewing staffing or bed capacity before the observed peak, and name the team that should validate it.
14. State at least two limitations: the data are synthetic and aggregated, and the visual does not adjust for seasonality, reporting delay, or regional denominators.
15. Apply the acceptance checks below, then submit the diagnostic CSV, trend PNG, quoted observable value, implication, and limitations as one evidence package.

Run from the Activity folder:

```bash
Rscript --vanilla activity01_time_series.R
```

Do not change the working directory inside R; each script resolves its own `data/` and `outputs/` paths.

## Expected outputs and values

- `outputs/setup_diagnostic.csv` has three checks and records the observed R/Bioconductor versions.
- `outputs/dengue_trend.png` contains 12 monthly points; the source has 36 rows across three regions.

## Verification

- The script exits without an unhandled error and creates at least one CSV in `outputs/`.
- Identifiers and dimensions are aligned before analysis.
- The interpretation quotes an observable value from the output.
- The conclusion states at least one limitation or control.

## Activity-specific troubleshooting

- If the observed R version is 4.4.3, the syntax path can run locally, but it does not prove the R 4.6/Bioconductor 3.23 environment target.
- If the plot device fails, confirm the `outputs/` folder is writable and close any locked PNG file.

## Reflection

What decision could this evidence support, and what additional validation would be required before real healthcare use?
