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

# Groups into which our data is divided.
# subcategories in coltrol variable
# rep("C2", 13),
# rep("C3", 12),
# rep("C4", 13),
# rep("C5", 11),
# rep("C6", 12),
groups <- c(
    rep("C", 74),
    rep("T1", 10),
    rep("T2", 10),
    rep("T3", 16),
    rep("T4", 9),
    rep("T5", 23),
    rep("T6", 19))

# Creation of a model matrix.
groups <- as.factor(groups)
design <- model.matrix(~groups)
# print(design)
