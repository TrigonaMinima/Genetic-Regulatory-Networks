library(genefilter)

# Standard deviation filter
# 1. Calculate the std deviation of every single gene
# 2. Retaining the genes with (sd >= 2)
std_filter <- function(analyzed_dat, fname){
    rsd <- rowSds(analyzed_dat)
    i <- rsd >= 2
    dat.f <- analyzed_dat[i,]

    print("Creating data dump... (dat.f.txt created)")
    write.table(dat.f,
        paste(fname, "dat.f.txt", sep=""),
        sep="\t",
        row.names=T,
        col.names=T,
        quote=F)

    rm(rsd, i)
    dat.f
}
