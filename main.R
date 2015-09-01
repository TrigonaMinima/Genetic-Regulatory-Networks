# source("http://www.bioconductor.org/biocLite.R")
# biocLite("affy")
library(affy)

# Loads all the data
source("data.R")

# Scripts loading the functions to be used by the main.R
source("std_dev_filter.R")
source("exp_filter.R")
source("analysis.R")
source("gsea.R")
source("GO.R")
source("KEGG.R")

# Source file for the quality control
source("qc.R")

# Removal of memory intensive objects
rm(dat, dat2)

# FILTERING BEFORE STATISTICAL TESTING
# Unspecific filtering of the data
dat.f <- std_filter(dat.m, "BeforeStatTest/StdFilter/")
dat.fo <- exp_filter(dat.m, "BeforeStatTest/ExpFilter/")

# Analysis of the data
dat.s1 <- analysis(dat.f, "BeforeStatTest/StdFilter/")
dat.s2 <- analysis(dat.fo, "BeforeStatTest/ExpFilter/")

# Gene set enrichment analysis
myids1 <- gsea(dat.s1, "BeforeStatTest/StdFilter/")
myids2 <- gsea(dat.s2, "BeforeStatTest/ExpFilter/")

# Analysis for GO categories
# result1 is kinda useless. There are only 3 genes out of which
# only 1 was recognized.
GO_result1 <- GO(myids1, "BeforeStatTest/StdFilter/")
GO_result2 <- GO(myids2, "BeforeStatTest/ExpFilter/")

# Analysis for KEGG pathways
# Here again, KEGG_result1 is useless.
KEGG_result1 <- KEGG(myids1, "BeforeStatTest/StdFilter/")
KEGG_result2 <- KEGG(myids2, "BeforeStatTest/ExpFilter/")

# Gene set test
source("gst.R")




source("hierarchical_clust.R")
source("kmeans.R")


# FILTERING AFTER STATISTICAL TESTING
# Unspecific filtering of the data
dat.s <- analysis(dat.m, "AfterStatTest/")

dat.s1 <- std_filter(dat.s, "AfterStatTest/StdFilter/")
dat.s2 <- exp_filter(dat.s, "AfterStatTest/ExpFilter/")

myids1 <- gsea(dat.s1dat.f, "AfterStatTest/StdFilter/")
myids2 <- gsea(dat.s2dat.fo, "AfterStatTest/ExpFilter/")
