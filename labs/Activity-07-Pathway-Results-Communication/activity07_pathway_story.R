args <- commandArgs(trailingOnly = FALSE)
script_arg <- grep("^--file=", args, value = TRUE)
script_dir <- if (length(script_arg)) dirname(normalizePath(sub("^--file=", "", script_arg))) else getwd()
data_dir <- file.path(script_dir, "data")
out_dir <- file.path(script_dir, "outputs")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)
message("Activity directory: ", script_dir)
genes <- read.csv(file.path(data_dir,"differential_genes.csv")); sets <- read.csv(file.path(data_dir,"mock_gene_sets.csv")); sig <- genes$gene[genes$adj_p<.05]
universe <- unique(sets$gene); enr <- do.call(rbind,lapply(split(sets$gene,sets$pathway),function(g){data.frame(overlap=sum(sig%in%g),set_size=length(g),p_value=phyper(sum(sig%in%g)-1,length(g),length(universe)-length(g),length(sig),lower.tail=FALSE))})); enr$pathway<-rownames(enr); enr$adj_p<-p.adjust(enr$p_value,"BH"); rownames(enr)<-NULL
write.csv(enr[order(enr$adj_p),],file.path(out_dir,"pathway_enrichment.csv"),row.names=FALSE)
png(file.path(out_dir,"pathway_evidence.png"),1000,650); barplot(-log10(pmax(enr$adj_p,1e-6)),names.arg=enr$pathway,las=2,col="#7C3AED",ylab="-log10 adjusted p"); dev.off()
