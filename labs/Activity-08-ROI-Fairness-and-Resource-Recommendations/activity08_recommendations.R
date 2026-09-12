args <- commandArgs(trailingOnly = FALSE)
script_arg <- grep("^--file=", args, value = TRUE)
script_dir <- if (length(script_arg)) dirname(normalizePath(sub("^--file=", "", script_arg))) else getwd()
data_dir <- file.path(script_dir, "data")
out_dir <- file.path(script_dir, "outputs")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
message("Activity directory: ", script_dir)
p <- read.csv(file.path(data_dir,"regional_predictions.csv")); cst <- read.csv(file.path(data_dir,"intervention_costs.csv")); d <- merge(p,cst,by="intervention"); d$expected_cases_avoided <- d$population*d$predicted_risk*d$effectiveness; d$benefit <- d$expected_cases_avoided*d$value_per_case; d$roi <- (d$benefit-d$program_cost)/d$program_cost
grp <- aggregate(cbind(predicted_risk,observed_rate)~region+group,d,mean); grp$calibration_gap<-grp$predicted_risk-grp$observed_rate
write.csv(d[order(-d$roi),],file.path(out_dir,"recommendation_matrix.csv"),row.names=FALSE); write.csv(grp,file.path(out_dir,"subgroup_check.csv"),row.names=FALSE)
