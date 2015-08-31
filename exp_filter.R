library(genefilter)

# Expression filter
# Gene expressed at the set level is at least in some
# proportion of the samples.
# kOverA -> uses absolute no of samples
# pOverA -> uses the proportion
#
# ff <- kOverA(A=1, p=0.5) (TODO: See how to use this)
#
# 1. Choose a filtering function (pOverA in this case) assuming
#     a) Intensity of a gene should be above log2(100) in at least 25
#          percent of the samples.
#     b) Interquartile range of log2–intensities should be at least 0.5
#
exp_filter <- function(analyzed_dat, fname){
    f1 <- pOverA(A=log2(100), p=0.25)
    f2 <- function(x) (IQR(x) > 0.5)
    ff <- filterfun(f1, f2)
    i <- genefilter(analysed_dat, ff)
    print(sum(i))
    dat.fo <- analysed_dat[i, ]

    print("Creating data dump... (dat.fo.txt created)")
    write.table(dat.fo,
        paste(fname, "dat.fo.txt", sep=""),
        sep="\t",
        row.names=T,
        col.names=T,
        quote=F)

    rm(f1, f2, ff, i)
    dat.fo
}
