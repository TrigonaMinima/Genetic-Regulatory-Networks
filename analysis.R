# Assumption: Data is normally distributed. Thus, using linear models.
# From a typical Affymetrix experiment, maybe only about
# 20% of the expression values are normally distributed.
# One should probably use non-parametric methods for the analysis
library(limma)

# Groups and model matrix were created by the data.R
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
