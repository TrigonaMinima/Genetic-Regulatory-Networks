# Assumption: Data is normally distributed. Thus, using linear models.
# From a typical Affymetrix experiment, maybe only about
# 20% of the expression values are normally distributed.
# One should probably use non-parametric methods for the analysis
library(limma)

    # rep("C2", 13),
    # rep("C3", 12),
    # rep("C4", 13),
    # rep("C5", 11),
    # rep("C6", 12),

# Groups into which our data is divided.
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

# On filtered data
analysis <- function(filter_dat, fname){
    fit <- lmFit(filter_dat, design)
    fit <- eBayes(fit)

    # Extracting the genes that have the unadjusted p-value at most 0.001
    #  TODO: Think about the other values of coeff.
    tt <- toptable(fit, coef=2, n=nrow(filter_dat))
    rn <- rownames(tt)[tt$P.Value <= 0.001]
    # rn <- as.numeric(rn)
    dat.s <- filter_dat[rn, ]
    print("Dumping dat.s...")

    write.table(dat.s,
        paste(fname, "dat.s.txt", sep=""),
        sep="\t",
        row.names=T,
        col.names=T,
        quote=F)

    rm(fit, tt, rn)
    dat.s
}



# fit <- lmFit(dat.f, design)
# fit <- eBayes(fit)

# # Extracting the genes that have the unadjusted p-value at most 0.001
# #  TODO: Think about the other values of coeff.
# tt <- toptable(fit, coef=2, n=nrow(dat.f))
# rn <- rownames(tt)[tt$P.Value <= 0.001]
# # rn <- as.numeric(rn)
# dat.s <- dat.f[rn, ]