args <- commandArgs(trailingOnly = FALSE)
script_arg <- grep("^--file=", args, value = TRUE)
script_dir <- if (length(script_arg)) dirname(normalizePath(sub("^--file=", "", script_arg))) else getwd()
data_dir <- file.path(script_dir, "data")
out_dir <- file.path(script_dir, "outputs")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
message("Activity directory: ", script_dir)
target_r <- numeric_version("4.6.0")
target_bioc <- "3.23"
have_bioc <- requireNamespace("BiocManager", quietly = TRUE)
installed_bioc <- if (have_bioc) as.character(BiocManager::version()) else NA_character_
status <- data.frame(check=c("R target","BiocManager","Bioconductor target"),
 observed=c(as.character(getRversion()), have_bioc, installed_bioc),
 expected=c(">= 4.6.0","installed","3.23"), stringsAsFactors=FALSE)
write.csv(status, file.path(out_dir,"setup_diagnostic.csv"), row.names=FALSE)
d <- read.csv(file.path(data_dir,"dengue_hospital_demand.csv"))
d$date <- as.Date(d$date); d$occupancy_pct <- 100*d$occupied_beds/d$staffed_beds
agg <- aggregate(cbind(cases,occupancy_pct)~date, d, mean)
png(file.path(out_dir,"dengue_trend.png"),1200,700); par(mar=c(5,5,2,5))
plot(agg$date,agg$cases,type="l",lwd=3,col="#1F6FEB",xlab="Month",ylab="Dengue cases")
par(new=TRUE); plot(agg$date,agg$occupancy_pct,type="l",lwd=3,col="#DC2626",axes=FALSE,xlab="",ylab="")
axis(4); mtext("Mean bed occupancy (%)",4,line=3); legend("topleft",c("Cases","Occupancy"),col=c("#1F6FEB","#DC2626"),lwd=3,bty="n"); dev.off()
cat("R target met:", getRversion() >= target_r, "
Bioconductor target:", installed_bioc, "
")
