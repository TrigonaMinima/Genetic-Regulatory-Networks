# Loading the CEL files
dat <- ReadAffy()
print(dat)

# QC stats plot
png("QC.png"), width=12, height=10, units="in", res=250)
aqc <- qc(dat)
plot(aqc)
dev.off()

# RNA degradation plot
# Sample a no. of colors from all available colors into cols
# distinct colors are equal to the no. of samples in dat object.
cols <- sample(colors(), nrow(pData(dat)))
deg <- AffyRNAdeg(dat)

# Plots the actual image using above colors,
png("rnadeg.png"), width=12, height=10, units="in", res=250)
plotAffyRNAdeg(deg, col=cols)
# A legend is added, for every array it holds one thin line
# colored using the above cols object.
legend(legend=sampleNames(dat), x="topleft", lty=1, cex=0.5, col=cols)
dev.off()


# Function rma() present in the package affy will be used here
# It takes in the raw data read previously.
dat2 <- rma(dat)
print(dat2)

# If the data is large and cannot fit into computer's memory, then
# the function justRMA() accomplishes the same task without reading
# the data into computer's memory.
# dat2 <- justRMA()

# The normalized data object (dat2) obtained here is in the format internal
# to the Bioconductor packages (affy).
# dat2
dat.m <- exprs(dat2)

# dat.m is the data object that will be used from now on,
# throughout the project.
# Removal of memory intensive objects
rm(dat, dat2)

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

# Groups into which our data is divided.
# subcategories in coltrol variable
# rep("C2", 13),
# rep("C3", 12),
# rep("C4", 13),
# rep("C5", 11),
# rep("C6", 12),
groups <- as.factor(c(
    rep("C", 74),
    rep("T1", 10),
    rep("T2", 10),
    rep("T3", 16),
    rep("T4", 9),
    rep("T5", 23),
    rep("T6", 19)))

# Creation of a model matrix.
# groups <- as.factor(groups)
design <- model.matrix(~groups)
print(design)
