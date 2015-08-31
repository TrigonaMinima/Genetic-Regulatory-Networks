# source("http://www.bioconductor.org/biocLite.R")
# biocLite("affy")
library(affy)

# Loading the CEL files
dat <- ReadAffy()
dat

# Data normalization
dat2 <- rma(dat)

# If the data is large and cannot fit into computer's memory, then
# the function justRMA() accomplishes the same task without reading
# the data into computer's memory.

# dat2 <- justRMA()

# The normalized data object (dat2) obtained here is in the format internal
# to the Bioconductor packages (affy).
# dat2
dat.m <- exprs(dat2)

# Write the "dat.m" tabe in a text file ("affymetrix.txt")
# using the function write.table()
write.table(dat.m,
    "affymetrix.txt",
    sep="\t",
    row.names=T,
    col.names=T,
    quote=F)

# Create a csv
write.csv(dat.m, "matrix.csv")

# Source file for the quality control
source("qc.R")

# Removal of memory intensive objects
rm(dat, dat2)


# FILTERING BEFORE STATISTICAL TESTING
# Unspecific filtering of the data
source("std_dev_filter.R")
dat.f <- std_filter(dat.m, "BeforeStatTest/StdFilter/")

source("exp_filter.R")
dat.fo <- exp_filter(dat.m, "BeforeStatTest/ExpFilter/")

# Analysis of the data
source("analysis.R")
dat.s1 <- analysis(dat.f, "BeforeStatTest/StdFilter/")
dat.s2 <- analysis(dat.fo, "BeforeStatTest/ExpFilter/")

source(gsea.R)

source("hierarchical_clust.R")
source("kmeans.R")


# FILTERING AFTER STATISTICAL TESTING
# Unspecific filtering of the data
dat.s <- analysis(dat.m, "AfterStatTest/")
dat.s1 <- std_filter(dat.s, "AfterStatTest/StdFilter/")
dat.s2 <- exp_filter(dat.s, "AfterStatTest/ExpFilter/")
