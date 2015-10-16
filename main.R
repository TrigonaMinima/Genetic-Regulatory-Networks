# source("http://www.bioconductor.org/biocLite.R")
# biocLite("affy")
library(affy)
library(simpleaffy)

# Loads all the data
source("data.R")

# tmpenv <- new.env()
# load("R.RData", envir=tmpenv)

# Scripts loading the functions to be used by the main.R
source("std_dev_filter.R")
source("exp_filter.R")
source("analysis.R")
source("gsea.R")
source("gsea_GO.R")
source("gsea_KEGG.R")
source("hierarchical_clust.R")
source("kmeans.R")

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
GO_result1 <- GO(myids1, "BeforeStatTest/StdFilter/")
GO_result2 <- GO(myids2, "BeforeStatTest/ExpFilter/")

# Analysis for KEGG pathways
# Here again, KEGG_result1 is useless.
KEGG_result1 <- KEGG(myids1, "BeforeStatTest/StdFilter/")
KEGG_result2 <- KEGG(myids2, "BeforeStatTest/ExpFilter/")

# Hierarchical Clustering
# Standard deviation filtered data
cluster(dat.f, "BeforeStatTest/StdFilter/")
# Statistically analysed, standard deviation data
cluster(dat.s1, "BeforeStatTest/StdFilter/stat_")
# Expression based filtered data
cluster(dat.fo, "BeforeStatTest/ExpFilter/")
# Statistically analysed, expression based filtered data
cluster(dat.s2, "BeforeStatTest/ExpFilter/stat_")

# KMeans Clustering
# Optimal no of clusters
# Standard deviation filtered data
optimal_clusters(dat.f, "BeforeStatTest/StdFilter/f_")
# Statistically analysed, standard deviation filtered data
optimal_clusters(dat.s1, "BeforeStatTest/StdFilter/s_")
# Expression based filtered data
optimal_clusters(dat.fo, "BeforeStatTest/ExpFilter/f_")
# Statistically analysed, expression based filtered data
optimal_clusters(dat.s2, "BeforeStatTest/ExpFilter/s_")

# Clustering
# No. of clusters to pass is to be determind from the above optimal clusters' plot
# Standard deviation filtered data
clustering(dat.f, 4, "BeforeStatTest/StdFilter/f_")
# Expression based filtered data
clustering(dat.fo, 4, "BeforeStatTest/ExpFilter/f_")
# Statistically analysed, expression based filtered data
clustering(dat.s2, 4, "BeforeStatTest/ExpFilter/s_")


# FILTERING AFTER STATISTICAL TESTING
# Unspecific filtering of the data
dat.s <- analysis(dat.m, "AfterStatTest/")

dat.s.f <- std_filter(dat.s, "AfterStatTest/StdFilter/")
dat.s.fo <- exp_filter(dat.s, "AfterStatTest/ExpFilter/")

myids.s.1 <- gsea(dat.s.f, "AfterStatTest/StdFilter/")
myids.s.2 <- gsea(dat.s.fo, "AfterStatTest/ExpFilter/")

GO_result.s.1 <- GO(myids.s.1, "AfterStatTest/StdFilter/")
GO_result.s.2 <- GO(myids.s.2, "AfterStatTest/ExpFilter/")

KEGG_result.s.1 <- KEGG(myids.s.1, "AfterStatTest/StdFilter/")
KEGG_result.s.2 <- KEGG(myids.s.2, "AfterStatTest/ExpFilter/")

# Hierarchical Clustering
# Statistically analyzed data
cluster(dat.s, "AfterStatTest/")
# Standard deviation filtered data
cluster(dat.s.f, "AfterStatTest/StdFilter/")
# Expression based filtered data
cluster(dat.s.fo, "AfterStatTest/ExpFilter/")

# KMeans Clustering
# Optimal no of clusters
# Statistically analysed data
optimal_clusters(dat.s, "AfterStatTest/")
# Statistically analysed, standard deviation filtered data
optimal_clusters(dat.s.f, "AfterStatTest/StdFilter/")
# Statistically analysed, expression based filtered data
optimal_clusters(dat.s.fo, "AfterStatTest/ExpFilter/")

# Clustering
# No. of clusters to pass is to be determind from the above optimal clusters' plot
# Statistically analysed data
clustering(dat.s, 4, "AfterStatTest/")
# Statistically analysed, expression based filtered data
clustering(dat.s.fo, 4, "AfterStatTest/ExpFilter/")
